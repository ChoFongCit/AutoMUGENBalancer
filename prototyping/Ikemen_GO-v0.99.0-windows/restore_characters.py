"""
restore_characters.py
---------------------
Restore one or more characters to a previous backup snapshot.

Usage
-----
  # Restore ALL characters to their most-recent backup
  python restore_characters.py

  # Restore specific characters to their most-recent backup
  python restore_characters.py Ryu Ken Akuma

  # Restore ALL characters to a specific snapshot timestamp
  python restore_characters.py --timestamp 20240101_120000

  # Restore specific characters to a specific snapshot
  python restore_characters.py Ryu Ken --timestamp 20240101_120000

  # List available snapshots for all (or specific) characters
  python restore_characters.py --list
  python restore_characters.py Ryu --list
"""

import argparse
import sys
from pathlib import Path

from roster_balancer import restore_from_backup, CSV_TO_FOLDER, CHARS_DIR

# All restorable characters (those with a folder mapping)
ALL_CHARS = sorted(CSV_TO_FOLDER.values())


def list_snapshots(char_names: list) -> None:
    """Print available backup snapshots for each character."""
    for name in char_names:
        char_dir    = CHARS_DIR / name
        backup_root = char_dir / "backups"

        print(f"\n{name}")
        print(f"  {'─' * 40}")

        if not backup_root.exists():
            print("  (no backups found)")
            continue

        snapshots = sorted(backup_root.iterdir())
        if not snapshots:
            print("  (no snapshots found)")
            continue

        for snap in reversed(snapshots):          # newest first
            files = [f.name for f in snap.iterdir()]
            print(f"  {snap.name}  →  {', '.join(files)}")


def restore_characters(char_names: list, timestamp: str = None) -> None:
    """Restore each character in char_names from the given (or latest) snapshot."""
    for name in char_names:
        char_dir = CHARS_DIR / name
        print(f"\n{'='*50}")
        print(f"  Restoring: {name}")
        print(f"{'='*50}")

        if not char_dir.exists():
            print(f"  [SKIP] Character folder not found: {char_dir}")
            continue

        restore_from_backup(char_dir, timestamp=timestamp)


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Restore MUGEN/Ikemen GO characters from a backup snapshot.",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog=__doc__,
    )
    parser.add_argument(
        "characters",
        nargs="*",
        metavar="CHARACTER",
        help=(
            "Character folder names to restore (e.g. Ryu Ken Akuma). "
            f"Defaults to all: {', '.join(ALL_CHARS)}"
        ),
    )
    parser.add_argument(
        "--timestamp", "-t",
        default=None,
        metavar="YYYYMMDD_HHMMSS",
        help="Snapshot to restore from. Defaults to the most-recent backup.",
    )
    parser.add_argument(
        "--list", "-l",
        action="store_true",
        help="List available backup snapshots instead of restoring.",
    )

    args = parser.parse_args()

    # Resolve target characters
    targets = args.characters if args.characters else ALL_CHARS

    # Validate names
    invalid = [c for c in targets if c not in ALL_CHARS]
    if invalid:
        print(f"Unknown character(s): {', '.join(invalid)}")
        print(f"Valid choices: {', '.join(ALL_CHARS)}")
        sys.exit(1)

    if args.list:
        list_snapshots(targets)
        return

    # Confirm before restoring all
    if not args.characters:
        print(f"About to restore ALL {len(targets)} characters")
        if args.timestamp:
            print(f"  Snapshot : {args.timestamp}")
        else:
            print("  Snapshot : (most recent for each character)")
        answer = input("\nProceed? [y/N] ").strip().lower()
        if answer != "y":
            print("Aborted.")
            return

    restore_characters(targets, timestamp=args.timestamp)

    print(f"\n{'='*50}")
    print("  Restore complete.")
    print(f"{'='*50}")


if __name__ == "__main__":
    main()
