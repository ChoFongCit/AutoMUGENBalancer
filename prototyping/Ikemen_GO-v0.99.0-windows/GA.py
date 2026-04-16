import os
import subprocess, shutil
import argparse
import sys
import re
from pathlib import Path
# from dataclasses import dataclass, field
# from itertools import combinations
# from typing import Optional

sys.path.append("../../")
import match_runner
import ai_script_gen
import match_log_parser
from GA_classes import Individual, CMD_Block


# Genetic algorithm that evolves MUGEN AI .cmd scripts using Ikemen GO.

#Example usage:
# put into character folder:
#   python GA.py input.cmd char.def --size -g 2
#   python GA.py ryu-AI.cmd -d Ryu-AI.def  --size 10 --generations 3



# ---------------------------------------------------------------------------
# Paths
# ---------------------------------------------------------------------------
CMD_DIR = "cmds"
DEF_DIR = "defs"
IKEMEN_PATH = r"C:\Users\greni\Desktop\works\Year4\Final Year Project\prototyping\Ikemen_GO-v0.99.0-windows\Ikemen_GO.exe"
IKEMEN_DIR = r"C:\Users\greni\Desktop\works\Year4\Final Year Project\prototyping\Ikemen_GO-v0.99.0-windows"

elite_count:     int   = 5
mutation_rate:   float = 0.2
new_blood_rate: float = 0.3
# ---------------------------------------------------------------------------
# Regexes
# ---------------------------------------------------------------------------
NUMBERED_TRIGGER_RE = re.compile(r"^\s*trigger\d+\s*=", re.IGNORECASE)
TRIGGERALL_RE       = re.compile(r"^\s*triggerall\s*=",  re.IGNORECASE)
STATE_MINUS1_RE     = re.compile(r"^\s*\[State\s+-1",    re.IGNORECASE)
STATE_HEADER_RE     = re.compile(r"^\s*\[State",          re.IGNORECASE)
     
def _body_to_block(header: str, body: list[str]) -> CMD_Block:
    """Split raw block body into preamble / triggers / trailer."""
    preamble_raw: list[str] = []
    triggers:     list[str] = []

    for ln in body:
        if NUMBERED_TRIGGER_RE.match(ln.rstrip("\n")):
            triggers.append(ln)
        else:
            preamble_raw.append(ln)

    trailer: list[str] = []
    while preamble_raw:
        last = preamble_raw[-1].strip()
        if last == "" or last.startswith(";"):
            trailer.insert(0, preamble_raw.pop())
        else:
            break

    return CMD_Block(header=header, preamble=preamble_raw,
                 triggers=triggers, trailer=trailer)


def patch_def(def_path, cmd_dir, out_dir):
    base_text = Path(def_path).read_text(encoding="utf-8", errors="replace")
    Path(out_dir).mkdir(parents=True, exist_ok=True)

    cmd_files = sorted(Path(cmd_dir).glob("*.cmd"))
    population_dict = dict()
    for i, cmd_file in enumerate(cmd_files):
        patched = base_text
        # Patch Name
        patched = re.sub(
            r'(^\s*Name\s*=\s*)"?([^"\n]+)"?',
            lambda m: f'{m.group(1)}"{m.group(2).strip()}_{i}"',
            patched, count=1, flags=re.IGNORECASE | re.MULTILINE,
        )
        char_name = re.search(r'(^\s*Name\s*=\s*)"?([^"\n]+)"?', patched, flags=re.IGNORECASE | re.MULTILINE).group(2)
        
        # Patch DisplayName
        patched = re.sub(
            r'(^\s*DisplayName\s*=\s*)"?([^"\n]+)"?',
            lambda m: f'{m.group(1)}"{m.group(2).strip()}_{i}"',
            patched, count=1, flags=re.IGNORECASE | re.MULTILINE,
        )
        # Patch Cmd
        patched = re.sub(
            r'(^\s*Cmd\s*=\s*).+',
            lambda m: f"{m.group(1)}{cmd_file.as_posix()}",
            patched, count=1, flags=re.IGNORECASE | re.MULTILINE,
        )
        out_path = Path(out_dir) / f"{Path(def_path).stem}_{i}.def"
        out_path.write_text(patched, encoding="utf-8")
        print(f"[{i:02d}] {out_path.name}  ->  {cmd_file.name}")
        
        population_dict[char_name] = Individual(def_path= f"{Path.cwd().name}/{out_path.name}", cmd_path=cmd_file.as_posix(), elo_rating=1000, name= char_name)
        
    return population_dict
        


# ---------------------------------------------------------------------------
# File parsing / assembly
# ---------------------------------------------------------------------------


def parse_cmd(lines: list[str]) -> tuple[list, list[CMD_Block]]:
    """Parse .cmd lines into (segments, blocks)."""
    segments:     list        = []
    blocks:       list[CMD_Block] = []
    current_pre:  list[str]   = []
    block_header: str         = ""
    block_body:   list[str]   = []
    inside_ai = False

    def close_pre():
        if current_pre:
            segments.append(("pre", list(current_pre)))
            current_pre.clear()

    def close_block():
        b = _body_to_block(block_header, block_body)
        segments.append(("block", b))
        blocks.append(b)

    for line in lines:
        stripped = line.rstrip("\n")
        if STATE_HEADER_RE.match(stripped):
            if inside_ai:
                close_block()
                inside_ai = False
            else:
                close_pre()
            if STATE_MINUS1_RE.match(stripped):
                inside_ai    = True
                block_header = line
                block_body   = []
            else:
                current_pre.append(line)
            continue
        if inside_ai:
            block_body.append(line)
        else:
            current_pre.append(line)

    if inside_ai:
        close_block()
    else:
        close_pre()

    return segments, blocks

def load_blocks(individual: Individual) -> None:
    """Parse the individual's .cmd file and populate segments + blocks."""
    lines = Path(individual.cmd_path).read_text(
        encoding="utf-8", errors="replace"
    ).splitlines(keepends=True)
    individual.segments, individual.blocks = parse_cmd(lines)

def assemble_cmd(segments: list, blocks: list[CMD_Block]) -> list[str]:
    """Reconstruct file lines from segments with current block contents."""
    block_iter = iter(blocks)
    output: list[str] = []
    for seg in segments:
        if seg[0] == "pre":
            output.extend(seg[1])
        else:
            output.extend(next(block_iter).to_lines())
    return output


def _resync_segments(segments: list, blocks: list[CMD_Block]) -> list:
    """Rebuild segment list so ('block', ...) entries point to the new blocks."""
    block_iter   = iter(blocks)
    new_segments = []
    for seg in segments:
        if seg[0] == "pre":
            new_segments.append(seg)
        else:
            new_segments.append(("block", next(block_iter)))
    return new_segments

def initialise_population(input_path,def_path ,output_dir, size):
    Path(output_dir).mkdir(parents=True, exist_ok=True)
    ai_script_gen.generate_population(input_path, output_dir, size)
    individual_dict = patch_def(def_path, CMD_DIR, Path.cwd())
    for ind in individual_dict.values():
        load_blocks(ind)
    return individual_dict

def elitism(population_dict: dict, n: int) -> list[Individual]:
    """
    Return the top n individuals by Elo rating, cloned unchanged.
    These pass directly into the next generation without modification.
    """
    sorted_pop = sorted(population_dict.values(),
                        key=lambda ind: ind.elo_rating, reverse=True)
    return [ind.clone(ind.name) for ind in sorted_pop[:n]]

def crossover(parent_a: Individual, parent_b: Individual,
              child_name: str) -> Individual:
    """
    Child starts as a clone of parent_a.
    A random number of block positions are replaced with blocks from parent_b.
    Both parents must have had load_blocks() called beforehand.
    """
    import random
    child   = parent_a.clone(child_name)
    n       = len(child.blocks)
    if n == 0 or len(parent_b.blocks) == 0:
        return child

    n_swap      = random.randint(1, n)
    child_slots = random.sample(range(n), n_swap)
    b_slots     = random.choices(range(len(parent_b.blocks)), k=n_swap)

    for cs, bs in zip(child_slots, b_slots):
        child.blocks[cs] = parent_b.blocks[bs].clone()

    child.segments = _resync_segments(child.segments, child.blocks)
    return child


def mutate(individual: Individual, rate: float = mutation_rate) -> None:
    """
    For each block, with probability `rate`, regenerate its trigger lines.
    Mutates in-place. Requires load_blocks() to have been called first.
    """
    import random
    for block in individual.blocks:
        if random.random() < rate:
            block.triggers = ai_script_gen.random_triggers()


def write_individual(individual: Individual, cmd_path: Path) -> None:
    """
    Assemble the individual's blocks back into a .cmd file and write it.
    Updates individual.cmd_path to the new path.
    """
    cmd_path.write_text(
        "".join(assemble_cmd(individual.segments, individual.blocks)),
        encoding="utf-8",
    )
    individual.cmd_path = str(cmd_path)

def next_generation(population_dict: dict, input_path: Path, def_path: Path,
                    output_dir: Path, def_dir: Path,
                    generation: int) -> dict:
    """
    Build the next generation:
      - Elites     : top elite_count pass through unchanged
      - New blood  : new_blood_rate % freshly generated from template
      - Children   : remainder filled by crossover + mutation from top half
    """
    import random
    sorted_pop = sorted(population_dict.values(),
                        key=lambda ind: ind.elo_rating, reverse=True)

    total       = len(population_dict)
    n_new_blood = max(1, int(total * new_blood_rate))
    new_pop: list[Individual] = []

    # 1 — Elites
    new_pop.extend(elitism(population_dict, elite_count))

    # 2 — New blood: freshly generated, no inheritance
    import tempfile, shutil
    with tempfile.TemporaryDirectory() as tmp:
        tmp_path = Path(tmp)
        ai_script_gen.generate_population(input_path, tmp_path, n_new_blood)
        for i, cmd_file in enumerate(sorted(tmp_path.glob("*.cmd"))):
            ind_name = f"g{generation:03d}_new_{i:02d}"
            ind = Individual(
                def_path   = "",
                cmd_path   = str(cmd_file),
                elo_rating = 1000,
                name       = ind_name,
            )
            load_blocks(ind)
            new_pop.append(ind)

    # 3 — Children: crossover + mutation from top half
    pool      = sorted_pop[:max(2, len(sorted_pop) // 2)]
    child_idx = 0
    while len(new_pop) < total:
        pa, pb     = random.sample(pool, 2)
        child_name = f"g{generation:03d}_child_{child_idx:02d}"
        child      = crossover(pa, pb, child_name)
        mutate(child)
        new_pop.append(child)
        child_idx += 1

    # Write all .cmd files and patch .def files
    output_dir.mkdir(exist_ok=True)
    for i, ind in enumerate(new_pop):
        cmd_path = output_dir / f"{i:02d}.cmd"
        write_individual(ind, cmd_path)

    new_dict = patch_def(def_path, output_dir, def_dir)
    for ind in new_dict.values():
        load_blocks(ind)

    return new_dict

def get_best_individual(population_dict: dict) -> Path:
    """
    Return the cmd_path of the individual with the highest Elo rating.
    """
    best = max(population_dict.values(), key=lambda ind: ind.elo_rating)
    print(f"Best individual: {best.name}  (Elo: {best.elo_rating:.1f})")
    return Path(best.cmd_path)

def update_champion_cmd(def_path, champion_cmd_path):
    """
    Overwrites the Cmd field in the original input.def with the champion's
    cmd file path after a complete GA run.

    Args:
        def_path (str | Path): path to the original input .def file
        champion_cmd_path (str | Path): path to the winning .cmd file
    """
    def_path = Path(def_path)
    champion_cmd_path = Path(champion_cmd_path)

    text = def_path.read_text(encoding="utf-8", errors="replace")

    patched = re.sub(
        r'(^\s*Cmd\s*=\s*).+',
        lambda m: f"{m.group(1)}{champion_cmd_path.as_posix()}",
        text, count=1, flags=re.IGNORECASE | re.MULTILINE,
    )

    if patched == text:
        print(f"[WARN] No Cmd field found in {def_path.name} — nothing updated.")
        return

    def_path.write_text(patched, encoding="utf-8")
    print(f"[Champion] {def_path.name}  ->  Cmd = {champion_cmd_path.name}")

def main():
    argparser = argparse.ArgumentParser(description="run GA AI script generation on selected .def and .cmd character")
    argparser.add_argument("input",help="path to original cmd file")
    argparser.add_argument("-def_path", "-d", help="path to .def file")
    argparser.add_argument("--size", help="size of population", default=10)
    argparser.add_argument("-g","--generations", help="number of generations to be run", default=1)
    args = argparser.parse_args()
    
    # parse path to be absolute
    input_path = Path(args.input).absolute()
    def_path = Path(args.def_path).absolute()
    working_dir = Path.cwd()
    output_dir = working_dir / CMD_DIR
    if output_dir.exists():
        shutil.rmtree(output_dir)
    Path(output_dir).mkdir()
    
    if not input_path.exists():
        print(f"ERROR: File not found: {input_path}", file=sys.stderr)
        sys.exit(1)
    if not def_path.exists():
        print(f"ERROR: File not found: {input_path}", file=sys.stderr)
        sys.exit(1)
        
    population = initialise_population(input_path, def_path, output_dir, int(args.size))
    # print(population)
    for p in population:
        print(f"{population[p].name} elo: {population[p].elo_rating}")
        
    generations = int(args.generations)
    for gen in range(1, generations + 1):
        print(f"\n--- Generation {gen} ---")
        
        for _ in range(1):
            match_log_parser.clean_char_logs(working_dir.name)
            match_runner.round_robin(population)
            log_list = match_log_parser.process_character_logs(working_dir.name)
            match_log_parser.adjust_elo(log_list=log_list, population_dict=population)
           

        for p in population:
            print(f"{population[p].name}  elo: {population[p].elo_rating:.1f}")

        if gen < generations:
            population = next_generation(
                population_dict=population,input_path=input_path ,def_path=def_path,
                output_dir = output_dir , def_dir= Path.cwd(),
                generation= gen + 1
            )
            
    best_cmd = get_best_individual(population)
    print(f"Champion cmd: {best_cmd}")
    update_champion_cmd(def_path, best_cmd)
    return best_cmd
    
    
if __name__ == "__main__":
    main()
