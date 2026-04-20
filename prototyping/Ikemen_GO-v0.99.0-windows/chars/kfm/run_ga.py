import sys
from pathlib import Path

# Point to the canonical GA.py two levels up
sys.path.insert(0, str(Path(__file__).resolve().parents[2]))

from GA import main


SIZE = 5
GENERATIONS = 3
if __name__ == "__main__":
    # Default args for Ryu — override any by passing CLI flags as normal
    defaults = [
        "kfm-AI.cmd",
        "-d", "kfm-AI.def",
        "--size", str(SIZE),
        "-g", str(GENERATIONS),
    ]
    # Only inject defaults if the user didn't pass their own args
    if len(sys.argv) == 1:
        sys.argv += defaults

    main()