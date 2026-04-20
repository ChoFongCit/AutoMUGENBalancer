"""
run_extract_all.py
------------------
Runs extract_moves on every character with a single *-AI.cns file under chars/.
Characters with multiple -AI.cns files are skipped.
Outputs one CSV per character into ML_data/, named <CharacterFolder>_moves.csv.
"""

from pathlib import Path
from extract_moves import extract_moves, write_csv

CHARS_DIR = Path("chars")
OUT_DIR   = Path("ML_data/moves")


def main():
    OUT_DIR.mkdir(exist_ok=True)

    cns_files = sorted(CHARS_DIR.rglob("*-AI.cns"))
    if not cns_files:
        print(f"No *-AI.cns files found under {CHARS_DIR.resolve()}")
        return

    by_char = {}
    for cns_path in cns_files:
        by_char.setdefault(cns_path.parent, []).append(cns_path)

    for char_dir, cns_list in sorted(by_char.items()):
        char_name = char_dir.name

        if len(cns_list) > 1:
            print(f"Skipping {char_name} — {len(cns_list)} AI.cns files")
            continue

        cns_path  = cns_list[0]
        air_files = list(char_dir.glob("*.air"))
        air_path  = air_files[0] if air_files else None
        air_label = air_path.name if air_path else "none"

        print(f"{char_name}/{cns_path.name}  +  {air_label}")

        moves   = extract_moves(cns_path, air_path)
        out_csv = OUT_DIR / f"{char_name}_moves.csv"
        write_csv(moves, out_csv)


if __name__ == "__main__":
    main()
