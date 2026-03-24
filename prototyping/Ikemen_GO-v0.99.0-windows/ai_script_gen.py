#!/usr/bin/env python3
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
 
 
# ---------------------------------------------------------------------------
# Trigger generators
# ---------------------------------------------------------------------------
# Each numbered trigger slot picks randomly from its own pool of valid
# expressions. InGuardDist is one option in slot 3 only -- not guaranteed
# in every block -- so it doesn't cause every move to fire on guard range.
# ---------------------------------------------------------------------------

def _dist_x() -> str:
    op  = random.choice(["<", ">", "<=", ">=", "="])
    val = random.randint(1, 1000)
    return f"P2BodyDist X {op} {val}"

def _dist_y() -> str:
    op  = random.choice(["<", ">", "<=", ">=", "="])
    val = random.randint(-1000, 1000)
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
    lambda: f"P2BodyDist X {random.choice(['<', '>', '<=', '>=', '='])} {random.randint(1, 1000)}",
    lambda: f"P2BodyDist Y {random.choice(['<', '>', '<=', '>=', '='])} {random.randint(-1000, 1000)}",
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
 
 
def flush_block(block_lines: list[str], stats: dict) -> list[str]:
    """
    Given the collected lines of one [State -1] block (excluding its header):
      - Keep all triggerall lines exactly as-is.
      - Remove all trigger1/2/3... numbered lines.
      - Append 6 fresh numbered trigger lines at the end (before trailing blanks).
    """
    kept_content    = []
    trailing_blanks = []
 
    for ln in block_lines:
        raw = ln.rstrip("\n")
        if NUMBERED_TRIGGER_RE.match(raw):
            stats["triggers_removed"] += 1   # drop numbered triggers
        else:
            kept_content.append(ln)           # keep everything else inc. triggerall
 
    # Inject AILevel guard after the last existing triggerall, or after the
    # first real content line if no triggerall lines are present.
    ailevel_line = "triggerall = AILevel != 0\n"
    already_has = any(
        re.search(r"triggerall\s*=\s*ailevel\s*!=\s*0", ln, re.IGNORECASE)
        for ln in kept_content
    )
    if not already_has:
        last_ta_idx = None
        for idx, ln in enumerate(kept_content):
            if TRIGGERALL_RE.match(ln.rstrip("\n")):
                last_ta_idx = idx
        if last_ta_idx is not None:
            kept_content.insert(last_ta_idx + 1, ailevel_line)
        else:
            insert_at = 0
            for idx, ln in enumerate(kept_content):
                s = ln.strip()
                if s and not s.startswith(";"):
                    insert_at = idx + 1
                    break
            kept_content.insert(insert_at, ailevel_line)
        stats["ailevel_injected"] += 1
 
    # Insert new triggers directly after the last triggerall line
    # so they sit adjacent to the triggerall section, before anything else.
    last_ta_idx = None
    for idx, ln in enumerate(kept_content):
        if TRIGGERALL_RE.match(ln.rstrip("\n")):
            last_ta_idx = idx
 
    new_triggers = build_trigger_block()
    stats["triggers_added"] += len(new_triggers)
 
    if last_ta_idx is not None:
        insert_at = last_ta_idx + 1
    else:
        # No triggerall at all — insert after the first real content line
        insert_at = 0
        for idx, ln in enumerate(kept_content):
            s = ln.strip()
            if s and not s.startswith(";"):
                insert_at = idx + 1
                break
 
    kept_content[insert_at:insert_at] = new_triggers
    return kept_content
 
 
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
        "blocks_processed":  0,
        "triggers_removed":  0,
        "triggers_added":    0,
        "ailevel_injected":  0,
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
 
    # Build flushed block lines for each block segment
    flushed_blocks = []
    for _, seg in block_segments:
        _, header, body = seg
        flushed = [header] + flush_block(body, stats)
        flushed_blocks.append(flushed)
 
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
 
 
# ---------------------------------------------------------------------------
# CLI
# ---------------------------------------------------------------------------
 
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
    print(f"  Trigger lines injected         : {stats['triggers_added']}")
    print(f"  AILevel guards injected        : {stats['ailevel_injected']}")
    print(f"  Blocks shuffled                : {args.shuffle}")
 
    if args.dry_run:
        print("\nDry run — no file written.")
        return
 
    output_path = Path(args.output) if args.output else \
        input_path.with_name(input_path.stem + "_replaced" + input_path.suffix)
 
    with output_path.open("w", encoding="utf-8") as fh:
        fh.writelines(new_lines)
 
    print(f"\nOutput written to: {output_path}")
 
 
if __name__ == "__main__":
    main()