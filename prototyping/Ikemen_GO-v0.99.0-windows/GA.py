import os
import subprocess
import argparse
import sys
import re
from pathlib import Path
# import ai_script_gen


#Example usage:
# put into character folder:
# python GA.py input.cmd char.def --size -g 2
#   python GA.py ryu-AI.cmd -d Ryu-AI.def  --size 1

CMD_DIR = "cmds"
DEF_DIR = "defs"
GEN_SCRIPT_PATH = r"C:\Users\greni\Desktop\works\Year4\Final Year Project\prototyping\Ikemen_GO-v0.99.0-windows\ai_script_gen.py"


def patch_def(def_path, cmd_dir, out_dir):
    base_text = Path(def_path).read_text(encoding="utf-8", errors="replace")
    Path(out_dir).mkdir(parents=True, exist_ok=True)

    cmd_files = sorted(Path(cmd_dir).glob("*.cmd"))
    for i, cmd_file in enumerate(cmd_files):
        patched = base_text
        # Patch Name
        patched = re.sub(
            r'(^\s*Name\s*=\s*)"?([^"\n]+)"?',
            lambda m: f'{m.group(1)}"{m.group(2).strip()}_{i}"',
            patched, count=1, flags=re.IGNORECASE | re.MULTILINE,
        )
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
        
        
        
def initialise_population(input_path,def_path ,output_dir, size):
    Path(output_dir).mkdir(parents=True, exist_ok=True)
    for i in range(size):
        cmd_name = f"{i:01}.cmd"
        output_path = f"{output_dir}/{cmd_name}"
        gen_script = [
            'python',
            GEN_SCRIPT_PATH,
            str(input_path),
            "--shuffle",
            "-o",
            output_path
                      ]
        
        proc = subprocess.Popen(gen_script)
        proc.wait()
    patch_def(def_path, CMD_DIR, Path.cwd())
        


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
    if not input_path.exists():
        print(f"ERROR: File not found: {input_path}", file=sys.stderr)
        sys.exit(1)
    if not def_path.exists():
        print(f"ERROR: File not found: {input_path}", file=sys.stderr)
        sys.exit(1)
    
    
    initialise_population(input_path, def_path, output_dir, int(args.size))
    
    
main()
