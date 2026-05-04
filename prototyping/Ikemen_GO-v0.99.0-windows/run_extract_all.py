"""
run_extract_all.py
------------------
Runs extract_moves on every character folder under chars/.
Reads whichever .cns the character's .def currently points to (so it always
reflects the active — possibly balanced — version).
Outputs one CSV per character into ML_data/moves/, named <CharacterFolder>_moves.csv.
"""

from pathlib import Path
from extract_moves import extract_moves, write_csv
from roster_balancer import _active_cns_from_def, CSV_TO_FOLDER

CHARS_DIR = Path("chars")
OUT_DIR   = Path("ML_data/moves")


def main():
    OUT_DIR.mkdir(exist_ok=True)

    # Only process characters that are in the balancer roster
    char_folders = sorted(set(CSV_TO_FOLDER.values()))

    for char_name in char_folders:
        char_dir = CHARS_DIR / char_name

        if not char_dir.exists():
            print(f"Skipping {char_name} — folder not found")
            continue

        cns_path = _active_cns_from_def(char_dir)
        if cns_path is None or not cns_path.exists():
            print(f"Skipping {char_name} — could not resolve active .cns from .def")
            continue

        # Match .air by same stem as active .cns, fall back to any .air
        air_path = cns_path.with_suffix(".air")
        if not air_path.exists():
            air_files = list(char_dir.glob("*.air"))
            air_path  = air_files[0] if air_files else None

        air_label = air_path.name if air_path else "none"
        print(f"{char_name}/{cns_path.name}  +  {air_label}")

        moves   = extract_moves(cns_path, air_path)
        out_csv = OUT_DIR / f"{char_name}_moves.csv"
        write_csv(moves, out_csv)


if __name__ == "__main__":
    main()
