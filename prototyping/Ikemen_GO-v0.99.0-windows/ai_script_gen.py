"""
mugen_ai_replace.py
-------------------
Reads a MUGEN .cmd / .cns file and rewrites every [State -1, ...] block so
that ALL existing trigger / triggerall lines are removed and replaced with
exactly 6 new trigger lines — one for each allowed trigger type — with fully
randomised operator and value:

    trigger1 = P2BodyDistX  <op> <val>
    trigger2 = P2BodyDistY  <op> <val>
    trigger3 = GuardDist
    trigger4 = P2MoveType   = <A|I|H>
    trigger5 = P2StateType  = <S|C|A>
    trigger6 = MoveContact  || MoveGuarded   (randomly one or both)

Everything else in each block (type=, value=, ignorehitpause=, var(), etc.)
is preserved exactly as-is.  Lines outside [State -1] blocks are untouched.

Usage:
    python ai_script_gen.py input.cmd
    python ai_script_gen.py input.cmd -o output.cmd
    python ai_script_gen.py input.cmd --dry-run
    python ai_script_gen.py input.cmd --seed 42     # reproducible output
    python ai_script_gen.py input.cmd --shuffle
"""

import re
import sys
import random
import argparse
from pathlib import Path
 
 
# ---------------------------------------------------------------------------
# Regexes
# ---------------------------------------------------------------------------
TRIGGER_LINE_RE  = re.compile(r"^\s*(triggerall|trigger\d+)\s*=", re.IGNORECASE)
STATE_MINUS1_RE  = re.compile(r"^\s*\[State\s+-1",               re.IGNORECASE)
STATE_HEADER_RE  = re.compile(r"^\s*\[State",                     re.IGNORECASE)
IHP_RE         = re.compile(r"^\s*ignorehitpause\s*=", re.IGNORECASE)
VARSET_TYPE_RE = re.compile(r"^\s*type\s*=\s*VarSet\b", re.IGNORECASE)
IFELSE_COMMAND_VALUE_RE = re.compile(
    r"^\s*value\s*=\s*IFelse\s*\(.*Command\s*=",
    re.IGNORECASE,
)
SYSTEM_TRIGGER_RE = re.compile(
    r"^\s*(triggerall|trigger\d+)\s*=.*\b("
    r"AILevel|IsHelper|ParentDist|NumHelper|Helper"
    r"|Parent|RootDist|Root|NumTarget|Target"
    r")\b",
    re.IGNORECASE,
)
VAR_FLAG_TRIGGER_RE = re.compile(
    r"^\s*(triggerall|trigger\d+)\s*=\s*!var\(59\)",
    re.IGNORECASE,
)
COMMAND_TRIGGER_RE = re.compile(
    r"^\s*(triggerall|trigger\d+)\s*=\s*[^=]*\bcommand\b",
    re.IGNORECASE,
)
 
 
# ---------------------------------------------------------------------------
# Trigger generators
# ---------------------------------------------------------------------------
# Each numbered trigger slot picks randomly from its own pool of valid
# expressions. InGuardDist is one option in slot 3 only -- not guaranteed
# in every block -- so it doesn't cause every move to fire on guard range.
# ---------------------------------------------------------------------------

def _dist_x() -> str:
    op  = random.choice(["<", ">", "<=", ">="])
    val = random.randint(0, 640)
    return f"P2BodyDist X {op} {val}"

def _dist_y() -> str:
    op  = random.choice(["<", ">", "<=", ">="])
    val = random.randint(-640, 640)
    return f"P2BodyDist Y {op} {val}"

def _move_type() -> str:
    return f"P2MoveType = {random.choice(['A', 'I', 'H'])}"

def _state_type() -> str:
    return f"P2StateType = {random.choice(['S', 'C', 'A'])}"

def _contact() -> str:
    return random.choice(["MoveContact", "MoveGuarded", "MoveContact || MoveGuarded"])


# Full pool of available trigger expressions. Each block picks a random
# subset (at least 1, at most all 6), so no trigger type is guaranteed to
# appear in every block. InGuardDist is just one option among many.
TRIGGER_POOL = [
    lambda: f"P2BodyDist X {random.choice(['<', '>', '<=', '>='])} {random.randint(0, 640)}",
    lambda: f"P2BodyDist Y {random.choice(['<', '>', '<=', '>='])} {random.randint(-640, 640)}",
    lambda: "InGuardDist",
    lambda: f"P2MoveType = {random.choice(['A', 'I', 'H'])}",
    lambda: f"P2StateType = {random.choice(['S', 'C', 'A'])}",
    lambda: random.choice(["MoveContact", "MoveGuarded", "MoveContact || MoveGuarded"]),
]


def build_trigger_block() -> list[str]:
    """
    Pick a random subset of triggers (1 to 6, no duplicates) from TRIGGER_POOL,
    evaluate each, and return them numbered trigger1..triggerN.
    """
    count   = random.randint(1, len(TRIGGER_POOL))
    chosen  = random.sample(TRIGGER_POOL, count)
    return [f"trigger{i} = {gen()}\n" for i, gen in enumerate(chosen, start=1)]
 
 
# ---------------------------------------------------------------------------
# Core processing
# ---------------------------------------------------------------------------
 
TRIGGERALL_RE       = re.compile(r"^\s*triggerall\s*=",  re.IGNORECASE)
NUMBERED_TRIGGER_RE = re.compile(r"^\s*trigger\d+\s*=", re.IGNORECASE)
VARSET_TYPE_RE      = re.compile(r"^\s*type\s*=\s*VarSet\b", re.IGNORECASE)

# Trigger lines referencing engine-internal or helper-system functions that
# are irrelevant (or contradictory) for a standalone ground character.
# Stripped from both triggerall and trigger# lines.
#   AILevel   – removed entirely; a clean `triggerall = AILevel != 0` is
#               re-injected later, so no AI guard is ever lost.
#   IsHelper / ParentDist / NumHelper / Helper / Parent / RootDist / Root
#             – helper/parent tree functions; meaningless for a base character.
#   NumTarget / Target – target-slot functions; unreliable outside helpers.
SYSTEM_TRIGGER_RE = re.compile(
    r"^\s*(triggerall|trigger\d+)\s*=.*\b("
    r"AILevel"
    r"|IsHelper"
    r"|ParentDist"
    r"|NumHelper"
    r"|Helper"
    r"|Parent"
    r"|RootDist"
    r"|Root"
    r"|NumTarget"
    r"|Target"
    r")\b",
    re.IGNORECASE,
)

# Trigger lines using specific var-flag conventions that are character- or
# screenpack-specific and should not be carried into generated scripts.
# Currently strips:  triggerall = !var(59)   (and any whitespace variants)
VAR_FLAG_TRIGGER_RE = re.compile(
    r"^\s*(triggerall|trigger\d+)\s*=\s*!var\(59\)",
    re.IGNORECASE,
)

# value = IFelse(Command=...) blocks are human-player input-routing blocks
# that select which state to enter based on which button was pressed.
# They are meaningless for AI-controlled characters and must not be
# randomised.  Blocks containing this pattern are preserved as-is
# (same treatment as VarSet blocks).
IFELSE_COMMAND_VALUE_RE = re.compile(
    r"^\s*value\s*=\s*IFelse\s*\(.*Command\s*=",
    re.IGNORECASE,
)
 
 
def flush_block(block_lines: list[str], stats: dict) -> list[str] | None:
    """
    Process one [State -1] block body (header line excluded):

      1. Return block unchanged if it is a VarSet block (AI flag housekeeping).
      2. Return None to drop the block if it contains an IFelse(Command=...)
         value line (human input-routing block, irrelevant for AI).
      3. Otherwise:
         a. Strip all numbered trigger lines.
         b. Strip system/helper/AILevel/var(59) triggerall lines.
         c. Inject `triggerall = AILevel != 0` after the last triggerall.
         d. Insert fresh random trigger lines immediately after the last triggerall.
         e. Re-attach ignorehitpause cleanly before any trailing blanks/comments.

    Returns the processed line list, or None if the block should be dropped.
    """

    # --- Guard 1: preserve VarSet blocks untouched -------------------------
    if any(VARSET_TYPE_RE.match(ln.rstrip("\n")) for ln in block_lines):
        return list(block_lines)

    # --- Guard 2: drop human input-routing blocks --------------------------
    if any(IFELSE_COMMAND_VALUE_RE.match(ln.rstrip("\n")) for ln in block_lines):
        stats["ifelse_command_removed"] += 1
        return None

    # --- Step 1: filter lines ----------------------------------------------
    kept:     list[str] = []
    ihp_lines: list[str] = []   # ignorehitpause lines — repositioned later

    for ln in block_lines:
        raw = ln.rstrip("\n")
        if NUMBERED_TRIGGER_RE.match(raw):
            stats["triggers_removed"] += 1
        elif SYSTEM_TRIGGER_RE.match(raw) or VAR_FLAG_TRIGGER_RE.match(raw):
            stats["system_triggers_removed"] += 1
        elif IHP_RE.match(raw):
            ihp_lines.append(ln)          # collect for later reattachment
        else:
            kept.append(ln)

    # --- Step 2: inject AILevel guard --------------------------------------
    ailevel_line = "triggerall = AILevel != 0\n"
    already_has  = any(
        re.search(r"triggerall\s*=\s*ailevel\s*!=\s*0", ln, re.IGNORECASE)
        for ln in kept
    )
    if not already_has:
        last_ta = next(
            (i for i in range(len(kept) - 1, -1, -1)
             if TRIGGERALL_RE.match(kept[i].rstrip("\n"))),
            None,
        )
        if last_ta is not None:
            kept.insert(last_ta + 1, ailevel_line)
        else:
            # No triggerall present — insert after first real content line
            insert_at = next(
                (i + 1 for i, ln in enumerate(kept)
                 if ln.strip() and not ln.strip().startswith(";")),
                0,
            )
            kept.insert(insert_at, ailevel_line)
        stats["ailevel_injected"] += 1

    # --- Step 3: insert new triggers after last triggerall -----------------
    new_triggers = build_trigger_block()
    stats["triggers_added"] += len(new_triggers)

    last_ta = next(
        (i for i in range(len(kept) - 1, -1, -1)
         if TRIGGERALL_RE.match(kept[i].rstrip("\n"))),
        None,
    )
    if last_ta is not None:
        trigger_insert = last_ta + 1
    else:
        trigger_insert = next(
            (i + 1 for i, ln in enumerate(kept)
             if ln.strip() and not ln.strip().startswith(";")),
            0,
        )
    kept[trigger_insert:trigger_insert] = new_triggers

    # --- Step 4: reattach ignorehitpause before trailing blanks/comments ---
    # Peel trailing blank/comment lines off the end
    trailer: list[str] = []
    while kept and (kept[-1].strip() == "" or kept[-1].strip().startswith(";")):
        trailer.insert(0, kept.pop())

    # ignorehitpause goes here, then the trailer is restored
    return kept + ihp_lines + trailer

 
 
def process_lines(lines: list[str], shuffle: bool = False) -> tuple[list[str], dict]:
    """
    Two-pass approach:
      Pass 1 — walk every line and bucket into segments:
               each segment is either a chunk of non-AI lines ('pre')
               or a [State -1] block ('block').
      Pass 2 — flush+replace triggers in every block, optionally shuffle
               the block order, then interleave with the non-AI segments
               to produce the final output.
 
    Non-AI content (preamble, [Statedef], [State NNN], comments between
    blocks) is always preserved in its original relative order.  Only the
    [State -1] blocks are shuffled among themselves.
    """
    stats = {
        "blocks_processed":         0,
        "triggers_removed":         0,
        "system_triggers_removed":  0,
        "triggers_added":           0,
        "ailevel_injected":         0,
        "ifelse_command_removed":   0,
    }
 
    # ------------------------------------------------------------------
    # Pass 1 — collect segments
    # Each entry is either:
    #   ("pre",   [lines])           — non-AI content
    #   ("block", header, [body])    — a [State -1] block
    # ------------------------------------------------------------------
    segments: list = []
    current_pre: list[str] = []
    block_header: str = ""
    block_body:   list[str] = []
    inside_ai = False
 
    def close_pre():
        if current_pre:
            segments.append(("pre", list(current_pre)))
            current_pre.clear()
 
    def close_block():
        segments.append(("block", block_header, list(block_body)))
        stats["blocks_processed"] += 1
 
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
 
    # Flush whatever is open at EOF
    if inside_ai:
        close_block()
    else:
        close_pre()
 
    # ------------------------------------------------------------------
    # Pass 2 — process blocks (replace triggers), optionally shuffle,
    #          then reassemble
    # ------------------------------------------------------------------
 
    # Separate pre-segments and block-segments while preserving order info
    pre_segments   = [(i, s) for i, s in enumerate(segments) if s[0] == "pre"]
    block_segments = [(i, s) for i, s in enumerate(segments) if s[0] == "block"]
 
    # Build flushed block lines for each block segment.
    # flush_block returns None for blocks that must be dropped entirely
    # (e.g. IFelse(Command=...) human-input-routing blocks).
    flushed_blocks = []
    for _, seg in block_segments:
        _, header, body = seg
        result = flush_block(body, stats)
        flushed_blocks.append([] if result is None else [header] + result)
 
    # Shuffle the flushed blocks if requested (keeps pre-segments in place)
    if shuffle:
        random.shuffle(flushed_blocks)
 
    # Reassemble: walk original segment order, substituting flushed blocks
    block_iter = iter(flushed_blocks)
    output: list[str] = []
    for seg in segments:
        if seg[0] == "pre":
            output.extend(seg[1])
        else:
            output.extend(next(block_iter))
 
    return output, stats
 

def generate_population(input_path: Path, output_dir: Path, size: int) -> list[Path]:
    """
    Generate `size` randomised .cmd files from input_path into output_dir.
    Returns a list of Paths to the generated files.
    """
    output_dir.mkdir(parents=True, exist_ok=True)
    generated = []
    for i in range(size):
        output_path = output_dir / f"{i:02d}.cmd"
        lines = input_path.read_text(encoding="utf-8", errors="replace").splitlines(keepends=True)
        new_lines, _ = process_lines(lines, shuffle=True)
        output_path.write_text("".join(new_lines), encoding="utf-8")
        generated.append(output_path)
    print(generated)
    return generated

def main():
    parser = argparse.ArgumentParser(
        description="Replace all triggers in MUGEN [State -1] blocks with randomised allowed triggers.",
    )
    parser.add_argument("input",  help="Path to input .cmd or .cns file")
    parser.add_argument("-o", "--output", default=None,
                        help="Output file path (default: <input>_replaced.cmd)")
    parser.add_argument("--dry-run", action="store_true",
                        help="Show stats only; do not write output file")
    parser.add_argument("--seed", type=int, default=None,
                        help="Random seed for reproducible results")
    parser.add_argument("--shuffle", action="store_true",
                        help="Randomly shuffle the order of [State -1] blocks")
    args = parser.parse_args()
 
    if args.seed is not None:
        random.seed(args.seed)
        print(f"Random seed: {args.seed}")
 
    input_path = Path(args.input)
    if not input_path.exists():
        print(f"ERROR: File not found: {input_path}", file=sys.stderr)
        sys.exit(1)
 
    print(f"Reading : {input_path}")
    with input_path.open("r", encoding="utf-8", errors="replace") as fh:
        lines = fh.readlines()
 
    new_lines, stats = process_lines(lines, shuffle=args.shuffle)
 
    print(f"\n--- Summary ---")
    print(f"  [State -1] blocks processed    : {stats['blocks_processed']}")
    print(f"  Trigger lines removed          : {stats['triggers_removed']}")
    print(f"  System trigger lines removed   : {stats['system_triggers_removed']}")
    print(f"  Trigger lines injected         : {stats['triggers_added']}")
    print(f"  AILevel guards injected        : {stats['ailevel_injected']}")
    print(f"  IFelse(Command) blocks removed : {stats['ifelse_command_removed']}")
    print(f"  Blocks shuffled                : {args.shuffle}")
 
    if args.dry_run:
        print("\nDry run — no file written.")
        return
 
    output_path = Path(args.output) if args.output else \
        input_path.with_name(input_path.stem + "_replaced" + input_path.suffix)
 
    with output_path.open("w", encoding="utf-8") as fh:
        fh.writelines(new_lines)
 
    print(f"\nOutput written to: {output_path}")
    pass
 
 
random_triggers = build_trigger_block

if __name__ == "__main__":
    main()