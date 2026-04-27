
"""
extract_moves.py
----------------
Extracts move frame data from MUGEN/Ikemen GO .cns and .air files.

For each attack state, extracts:
  - state_id        : statedef number
  - anim_id         : animation action used (may differ from state_id)
  - is_aerial       : True if Statedef type = A
  - juggle          : juggle cost from Statedef header
  - startup         : frames before first active hitbox frame (from .air)
  - active          : frames the hitbox is active (from .air)
  - recovery        : frames after last active frame (from .air)
  - total_frames    : total animation length in frames (from .air)
  - damage          : damage expression from HitDef (first hit)
  - hit_stun        : ground.hittime
  - guard_stun      : guard.ctrltime
  - attribute       : attr field e.g. "S, NA"
  - hit_type        : ground.type (High / Low / Trip)
  - pausetime       : pausetime field
  - multi_hit       : True if more than one HitDef in the state

Usage:
    python extract_moves.py ryu.cns
    python extract_moves.py ryu.cns --air ryu.air
    python extract_moves.py ryu.cns --air ryu.air -o moves.csv
    python extract_moves.py ryu.cns --air ryu.air --json
    python extract_moves.py ryu.cns --air ryu.air --print
"""

import re
import csv
import json
import argparse
import sys
from pathlib import Path


# ---------------------------------------------------------------------------
# CNS regexes
# ---------------------------------------------------------------------------
STATEDEF_RE = re.compile(
    r'\[Statedef\s+(\d+)\](.*?)(?=\[Statedef\s|\Z)',
    re.DOTALL | re.IGNORECASE,
)
HITDEF_RE = re.compile(
    r'\[State[^\]]*\]\s*type\s*=\s*HitDef(.*?)(?=\[State|\Z)',
    re.DOTALL | re.IGNORECASE,
)


def _get(pattern, text, group=1, flags=re.IGNORECASE):
    m = re.search(pattern, text, flags)
    return m.group(group).strip() if m else None


def _get_int(pattern, text):
    val = _get(pattern, text)
    if val is None:
        return None
    nums = re.findall(r'-?\d+', val)
    return int(nums[0]) if nums else None


def parse_damage(damage_str):
    """Return damage expression stripped of inline comments."""
    if not damage_str:
        return None
    return damage_str.split(';')[0].strip()


# ---------------------------------------------------------------------------
# AIR file parsing
# ---------------------------------------------------------------------------

def parse_air(air_path: Path) -> dict:
    """
    Parse a .air file and return a dict mapping action_id -> list of frame dicts.
    Each frame dict: { duration: int, has_hitbox: bool }

    Frame line format: sprite_group, sprite_idx, x, y, duration
    Clsn1 blocks immediately before a frame line mark that frame as active.
    Duration of -1 means loop forever — treated as 1 frame.
    """
    content   = air_path.read_text(encoding='utf-8', errors='replace')
    action_re = re.compile(
        r'\[Begin Action\s+(\d+)\](.*?)(?=\[Begin Action|\Z)',
        re.DOTALL | re.IGNORECASE,
    )
    actions = {}

    for m in action_re.finditer(content):
        action_id     = int(m.group(1))
        lines         = m.group(2).split('\n')
        frames        = []
        pending_clsn1 = False

        for line in lines:
            s = line.strip()
            if re.match(r'Clsn1\s*:', s, re.IGNORECASE):
                pending_clsn1 = True
            elif re.match(r'^\d+\s*,\s*\d+\s*,\s*-?\d+\s*,\s*-?\d+\s*,\s*-?\d+', s):
                dur_str  = s.split(',')[4].split(';')[0].strip()
                dur_m    = re.match(r'-?\d+', dur_str)
                raw_dur  = int(dur_m.group()) if dur_m else 1
                duration = max(1, raw_dur)  # -1 = hold forever -> treat as 1
                frames.append({'duration': duration, 'has_hitbox': pending_clsn1})
                pending_clsn1 = False

        actions[action_id] = frames

    return actions


def calc_frame_data(frames: list) -> dict:
    """
    Calculate startup / active / recovery / total from a frame list.

    startup  = sum of pre-hitbox frame durations + 1
               (convention: frame 1 is the first active frame)
    active   = total duration of all frames with Clsn1
    recovery = total duration of frames after the last active frame
    total    = sum of all frame durations
    """
    if not frames:
        return {}

    total     = sum(f['duration'] for f in frames)
    first_hit = next((i for i, f in enumerate(frames) if f['has_hitbox']), None)

    if first_hit is None:
        return {'total_frames': total, 'startup': None, 'active': None, 'recovery': None}

    last_hit = max(i for i, f in enumerate(frames) if f['has_hitbox'])
    startup  = sum(f['duration'] for f in frames[:first_hit]) + 1
    active   = sum(f['duration'] for f in frames[first_hit:last_hit + 1])
    recovery = sum(f['duration'] for f in frames[last_hit + 1:])

    return {
        'total_frames': total,
        'startup':      startup,
        'active':       active,
        'recovery':     recovery,
    }


# ---------------------------------------------------------------------------
# CNS state extraction
# ---------------------------------------------------------------------------

def extract_hitdef_data(hitdef_body: str) -> dict:
    damage_raw = _get(r'\bdamage\s*=\s*([^\n;]+)', hitdef_body)
    return {
        'damage':     parse_damage(damage_raw),
        'hit_stun':   _get_int(r'\bground\.hittime\s*=\s*(-?\d+)', hitdef_body),
        'guard_stun': _get_int(r'\bguard\.ctrltime\s*=\s*(-?\d+)', hitdef_body),
        'attribute':  _get(r'\battr\s*=\s*([^\n]+)', hitdef_body),
        'hit_type':   _get(r'\bground\.type\s*=\s*(\w+)', hitdef_body),
        'pausetime':  _get(r'\bpausetime\s*=\s*([^\n]+)', hitdef_body),
    }


def extract_state(state_id: int, statedef_body: str, air_actions: dict):
    """
    Extract move data from one Statedef block.
    Returns None if not an attack state with a HitDef.
    """
    movetype = _get(r'\bmovetype\s*=\s*(\w+)', statedef_body)
    if movetype and movetype.upper() != 'A':
        return None

    hitdefs = list(HITDEF_RE.finditer(statedef_body))
    if not hitdefs:
        return None

    primary       = extract_hitdef_data(hitdefs[0].group(1))
    statedef_type = _get(r'^\s*type\s*=\s*(\w+)', statedef_body,
                         flags=re.IGNORECASE | re.MULTILINE)
    juggle        = _get_int(r'\bjuggle\s*=\s*(\d+)', statedef_body)

    # Resolve animation id — defaults to state_id, may be overridden by anim =
    anim_id_raw = _get(r'^\s*anim\s*=\s*(\S+)', statedef_body,
                       flags=re.IGNORECASE | re.MULTILINE)
    try:
        anim_id = int(anim_id_raw) if anim_id_raw else state_id
    except ValueError:
        anim_id = state_id  # expression (e.g. ifelse) — fall back

    # Frame data from .air: try resolved anim_id first, fall back to state_id
    frames    = air_actions.get(anim_id, air_actions.get(state_id, []))
    framedata = calc_frame_data(frames)

    return {
        'state_id':   state_id,
        'anim_id':    anim_id,
        'is_aerial':  statedef_type.upper() == 'A' if statedef_type else False,
        'juggle':     juggle,
        'multi_hit':  len(hitdefs) > 1,
        **primary,
        **framedata,
    }


# ---------------------------------------------------------------------------
# File-level extraction
# ---------------------------------------------------------------------------

def extract_moves(cns_path: Path, air_path: Path = None) -> list:
    """Parse .cns (and optionally .air) and return a list of move data dicts."""
    text        = cns_path.read_text(encoding='utf-8', errors='replace')
    air_actions = parse_air(air_path) if air_path else {}
    moves       = []

    for m in STATEDEF_RE.finditer(text):
        result = extract_state(int(m.group(1)), m.group(2), air_actions)
        if result:
            moves.append(result)

    return moves


# ---------------------------------------------------------------------------
# Output helpers
# ---------------------------------------------------------------------------

FIELDS = [
    'state_id', 'anim_id', 'is_aerial', 'juggle',
    'startup', 'active', 'recovery', 'total_frames',
    'damage', 'hit_stun', 'guard_stun',
    'attribute', 'hit_type', 'pausetime', 'multi_hit',
]


def write_csv(moves: list, out_path: Path) -> None:
    with out_path.open('w', newline='', encoding='utf-8') as f:
        writer = csv.DictWriter(f, fieldnames=FIELDS, extrasaction='ignore')
        writer.writeheader()
        writer.writerows(moves)
    print(f"CSV written to {out_path}  ({len(moves)} moves)")


def write_json(moves: list, out_path: Path) -> None:
    out_path.write_text(json.dumps(moves, indent=2), encoding='utf-8')
    print(f"JSON written to {out_path}  ({len(moves)} moves)")


def print_table(moves: list) -> None:
    hdr = (f"{'ID':>6}  {'Air':>3}  {'Jgl':>3}  "
           f"{'Start':>5}  {'Act':>3}  {'Rec':>3}  {'Tot':>3}  "
           f"{'Dmg':<28}  {'HStun':>5}  {'GStun':>5}  "
           f"{'Attr':<10}  {'HType':<5}  {'Multi':>5}")
    print(hdr)
    print('-' * len(hdr))
    for mv in moves:
        print(
            f"{mv['state_id']:>6}  "
            f"{'Y' if mv['is_aerial'] else 'N':>3}  "
            f"{str(mv.get('juggle') or '?'):>3}  "
            f"{str(mv.get('startup') or '?'):>5}  "
            f"{str(mv.get('active') or '?'):>3}  "
            f"{str(mv.get('recovery') or '?'):>3}  "
            f"{str(mv.get('total_frames') or '?'):>3}  "
            f"{str(mv.get('damage') or '?'):<28}  "
            f"{str(mv.get('hit_stun') or '?'):>5}  "
            f"{str(mv.get('guard_stun') or '?'):>5}  "
            f"{str(mv.get('attribute') or '?'):<10}  "
            f"{str(mv.get('hit_type') or '?'):<5}  "
            f"{'Y' if mv.get('multi_hit') else 'N':>5}"
        )


# ---------------------------------------------------------------------------
# CLI
# ---------------------------------------------------------------------------

def main():
    parser = argparse.ArgumentParser(
        description='Extract move frame data from MUGEN .cns and .air files.')
    parser.add_argument('cns',  help='Path to the .cns file')
    parser.add_argument('--air', default=None,
                        help='Path to the .air file (auto-detected if omitted)')
    parser.add_argument('-o', '--output', default=None,
                        help='Output CSV path (default: <cns_stem>_moves.csv)')
    parser.add_argument('--json', action='store_true',
                        help='Output JSON instead of CSV')
    parser.add_argument('--print', action='store_true', dest='print_table',
                        help='Print summary table to stdout')
    args = parser.parse_args()

    cns_path = Path(args.cns)
    if not cns_path.exists():
        print(f"ERROR: CNS not found: {cns_path}", file=sys.stderr)
        sys.exit(1)

    # Auto-detect .air in same directory if not specified
    if args.air:
        air_path = Path(args.air)
    else:
        candidate = cns_path.with_suffix('.air')
        air_path  = candidate if candidate.exists() else None

    if air_path:
        print(f"Using AIR: {air_path}")
    else:
        print("No AIR file — startup/active/recovery will be empty")

    moves = extract_moves(cns_path, air_path)
    print(f"Extracted {len(moves)} attack states from {cns_path.name}")

    if args.print_table or (not args.output and not args.json):
        print_table(moves)

    if args.json:
        out = Path(args.output) if args.output else \
            cns_path.with_name(cns_path.stem + '_moves.json')
        write_json(moves, out)
    elif args.output:
        write_csv(moves, Path(args.output))
    else:
        out = cns_path.with_name(cns_path.stem + '_moves.csv')
        write_csv(moves, out)


if __name__ == '__main__':
    main()