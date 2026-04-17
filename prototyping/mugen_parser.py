"""
mugen_parser.py
Parses MUGEN/Ikemen character files:
  - .cns  : character state/movelist data
  - .air  : animation and collision-box data
"""

import re
from dataclasses import dataclass, field
from typing import Optional


# ---------------------------------------------------------------------------
# Shared helpers
# ---------------------------------------------------------------------------

def _strip_comment(line: str) -> str:
    """Remove inline ; comments and strip whitespace."""
    idx = line.find(";")
    return line[:idx].strip() if idx != -1 else line.strip()


def _parse_kv(line: str) -> Optional[tuple[str, str]]:
    """Return (key, value) if the line is a key = value pair, else None."""
    if "=" not in line:
        return None
    key, _, value = line.partition("=")
    return key.strip().lower(), value.strip()


# ===========================================================================
# CNS parser
# ===========================================================================

@dataclass
class HitDef:
    attr: str = ""
    damage: str = ""
    animtype: str = ""
    hitflag: str = ""
    guardflag: str = ""
    ground_type: str = ""
    air_type: str = ""
    priority: str = ""
    sparkno: str = ""
    hitsound: str = ""
    guardsound: str = ""
    ground_velocity: str = ""
    air_velocity: str = ""
    pausetime: str = ""
    extra: dict = field(default_factory=dict)

    def to_dict(self) -> dict:
        d = {k: v for k, v in self.__dict__.items() if k != "extra" and v}
        d.update(self.extra)
        return d


@dataclass
class StateAction:
    """One [State N] block inside a Statedef."""
    state_id: str = ""
    action_type: str = ""        # e.g. HitDef, ChangeAnim, ChangeState …
    triggers: list[str] = field(default_factory=list)
    params: dict = field(default_factory=dict)
    hitdef: Optional[HitDef] = None


@dataclass
class StateDef:
    state_id: int = 0
    state_type: str = ""         # S / C / A
    move_type: str = ""          # A (attack) / I (idle) / H (hit)
    physics: str = ""
    juggle: Optional[int] = None
    anim: Optional[int] = None
    ctrl: Optional[int] = None
    velset: str = ""
    extra: dict = field(default_factory=dict)
    actions: list[StateAction] = field(default_factory=list)

    @property
    def hitdefs(self) -> list[HitDef]:
        return [a.hitdef for a in self.actions if a.hitdef]

    def to_dict(self) -> dict:
        return {
            "state_id": self.state_id,
            "type": self.state_type,
            "movetype": self.move_type,
            "physics": self.physics,
            "juggle": self.juggle,
            "anim": self.anim,
            "ctrl": self.ctrl,
            "velset": self.velset,
            **self.extra,
            "actions": [
                {
                    "id": a.state_id,
                    "type": a.action_type,
                    "triggers": a.triggers,
                    "params": a.params,
                    **({"hitdef": a.hitdef.to_dict()} if a.hitdef else {}),
                }
                for a in self.actions
            ],
        }


class CNSParser:
    """Parse a MUGEN .cns file into structured data."""

    # Top-level sections that are plain key-value tables (not Statedefs)
    _KV_SECTIONS = {"data", "size", "velocity", "movement"}

    # HitDef fields we promote to named attributes
    _HITDEF_NAMED = {
        "attr", "damage", "animtype", "hitflag", "guardflag",
        "ground.type", "air.type", "priority", "sparkno", "hitsound",
        "guardsound", "ground.velocity", "air.velocity", "pausetime",
    }

    def __init__(self):
        self.sections: dict[str, dict] = {}   # named sections (Data, Size …)
        self.statedefs: dict[int, StateDef] = {}

    # ------------------------------------------------------------------
    def parse_file(self, path: str) -> "CNSParser":
        with open(path, encoding="utf-8", errors="replace") as fh:
            lines = fh.readlines()
        self._parse_lines(lines)
        return self

    # ------------------------------------------------------------------
    def _parse_lines(self, lines):
        current_section: Optional[str] = None
        current_statedef: Optional[StateDef] = None
        current_action: Optional[StateAction] = None

        header_re = re.compile(r"^\[([^\]]+)\]")

        for raw in lines:
            line = _strip_comment(raw)
            if not line:
                continue

            # --- Section / Statedef header ---
            m = header_re.match(line)
            if m:
                header = m.group(1).strip()

                # State block inside a Statedef  e.g. [State 200, 1]
                state_m = re.match(r"^[Ss]tate\s+([-\d]+)(?:,\s*(.+))?$", header)
                statedef_m = re.match(r"^[Ss]tatedef\s+(-?\d+)$", header)

                if statedef_m:
                    sid = int(statedef_m.group(1))
                    current_statedef = StateDef(state_id=sid)
                    self.statedefs[sid] = current_statedef
                    current_action = None
                    current_section = None

                elif state_m and current_statedef is not None:
                    current_action = StateAction(state_id=state_m.group(1))
                    current_statedef.actions.append(current_action)

                else:
                    sec_name = header.lower()
                    if sec_name in self._KV_SECTIONS:
                        current_section = sec_name
                        self.sections.setdefault(current_section, {})
                    current_statedef = None
                    current_action = None
                continue

            # --- Key-value line ---
            kv = _parse_kv(line)
            if kv is None:
                continue
            key, value = kv

            # Inside a named top-level section
            if current_section and current_statedef is None:
                self.sections[current_section][key] = value
                continue

            # Inside a Statedef header (before first [State …])
            if current_statedef is not None and current_action is None:
                self._apply_statedef_kv(current_statedef, key, value)
                continue

            # Inside a State action block
            if current_action is not None:
                self._apply_action_kv(current_action, key, value)

    # ------------------------------------------------------------------
    def _apply_statedef_kv(self, sd: StateDef, key: str, value: str):
        if key == "type":
            sd.state_type = value.upper()
        elif key == "movetype":
            sd.move_type = value.upper()
        elif key == "physics":
            sd.physics = value.upper()
        elif key == "juggle":
            try:
                sd.juggle = int(value)
            except ValueError:
                sd.juggle = None
        elif key == "anim":
            try:
                sd.anim = int(value)
            except ValueError:
                pass
        elif key == "ctrl":
            try:
                sd.ctrl = int(value)
            except ValueError:
                pass
        elif key == "velset":
            sd.velset = value
        else:
            sd.extra[key] = value

    # ------------------------------------------------------------------
    def _apply_action_kv(self, action: StateAction, key: str, value: str):
        if key == "type":
            action.action_type = value
            # Lazily create HitDef object when we see type = HitDef
            if value.lower() == "hitdef":
                action.hitdef = HitDef()
        elif key.startswith("trigger"):
            action.triggers.append(f"{key} = {value}")
        else:
            action.params[key] = value
            # Populate HitDef fields
            if action.hitdef is not None:
                self._apply_hitdef_kv(action.hitdef, key, value)

    # ------------------------------------------------------------------
    def _apply_hitdef_kv(self, hd: HitDef, key: str, value: str):
        mapping = {
            "attr": "attr",
            "damage": "damage",
            "animtype": "animtype",
            "hitflag": "hitflag",
            "guardflag": "guardflag",
            "ground.type": "ground_type",
            "air.type": "air_type",
            "priority": "priority",
            "sparkno": "sparkno",
            "hitsound": "hitsound",
            "guardsound": "guardsound",
            "ground.velocity": "ground_velocity",
            "air.velocity": "air_velocity",
            "pausetime": "pausetime",
        }
        attr_name = mapping.get(key)
        if attr_name:
            setattr(hd, attr_name, value)
        else:
            hd.extra[key] = value

    # ------------------------------------------------------------------
    # Convenience accessors
    # ------------------------------------------------------------------

    def get_section(self, name: str) -> dict:
        return self.sections.get(name.lower(), {})

    def get_attack_states(self) -> list[StateDef]:
        """Return all Statedefs whose movetype is 'A' (attack)."""
        return [sd for sd in self.statedefs.values() if sd.move_type == "A"]

    def get_hitdefs(self) -> list[tuple[int, HitDef]]:
        """Return (state_id, HitDef) pairs for every attack state."""
        result = []
        for sd in self.get_attack_states():
            for hd in sd.hitdefs:
                result.append((sd.state_id, hd))
        return result


# ===========================================================================
# AIR parser
# ===========================================================================

@dataclass
class CollisionBox:
    x1: int
    y1: int
    x2: int
    y2: int

    def to_dict(self) -> dict:
        return {"x1": self.x1, "y1": self.y1, "x2": self.x2, "y2": self.y2}


@dataclass
class AnimFrame:
    group: int
    sprite: int
    x_offset: int
    y_offset: int
    duration: int                        # -1 = stay until interrupted
    clsn1: list[CollisionBox] = field(default_factory=list)   # attack boxes
    clsn2: list[CollisionBox] = field(default_factory=list)   # body/hurt boxes
    is_loop_start: bool = False

    def to_dict(self) -> dict:
        return {
            "group": self.group,
            "sprite": self.sprite,
            "x_offset": self.x_offset,
            "y_offset": self.y_offset,
            "duration": self.duration,
            "loop_start": self.is_loop_start,
            "clsn1_attack": [b.to_dict() for b in self.clsn1],
            "clsn2_body": [b.to_dict() for b in self.clsn2],
        }


@dataclass
class Action:
    action_id: int
    frames: list[AnimFrame] = field(default_factory=list)

    @property
    def loop_start(self) -> Optional[int]:
        for i, f in enumerate(self.frames):
            if f.is_loop_start:
                return i
        return None

    @property
    def total_duration(self) -> int:
        return sum(f.duration for f in self.frames if f.duration > 0)

    def to_dict(self) -> dict:
        return {
            "action_id": self.action_id,
            "loop_start_frame": self.loop_start,
            "total_duration": self.total_duration,
            "frames": [f.to_dict() for f in self.frames],
        }


class AIRParser:
    """Parse a MUGEN .air animation file."""

    _FRAME_RE = re.compile(
        r"^(-?\d+)\s*,\s*(-?\d+)\s*,\s*(-?\d+)\s*,\s*(-?\d+)\s*,\s*(-?\d+)"
    )
    _BOX_RE = re.compile(
        r"^\s*[Cc]lsn[12]\[\d+\]\s*=\s*(-?\d+)\s*,\s*(-?\d+)\s*,\s*(-?\d+)\s*,\s*(-?\d+)"
    )
    _CLSN_HDR_RE = re.compile(r"^\s*[Cc]lsn([12])\s*:\s*(\d+)")
    _ACTION_RE = re.compile(r"^\[Begin\s+Action\s+(\d+)\]", re.IGNORECASE)

    def __init__(self):
        self.actions: dict[int, Action] = {}

    # ------------------------------------------------------------------
    def parse_file(self, path: str) -> "AIRParser":
        with open(path, encoding="utf-8", errors="replace") as fh:
            lines = fh.readlines()
        self._parse_lines(lines)
        return self

    # ------------------------------------------------------------------
    def _parse_lines(self, lines):
        current_action: Optional[Action] = None
        pending_clsn1: list[CollisionBox] = []
        pending_clsn2: list[CollisionBox] = []
        collecting_clsn: Optional[int] = None   # 1 or 2
        expected_boxes = 0
        collected_boxes = 0
        loop_flag = False

        for raw in lines:
            line = _strip_comment(raw)
            if not line:
                continue

            # [Begin Action N]
            m = self._ACTION_RE.match(line)
            if m:
                current_action = Action(action_id=int(m.group(1)))
                self.actions[current_action.action_id] = current_action
                pending_clsn1, pending_clsn2 = [], []
                collecting_clsn = None
                loop_flag = False
                continue

            if current_action is None:
                continue

            # Loopstart
            if line.lower() == "loopstart":
                loop_flag = True
                continue

            # Clsn header  e.g.  Clsn2: 3
            m = self._CLSN_HDR_RE.match(line)
            if m:
                collecting_clsn = int(m.group(1))
                expected_boxes = int(m.group(2))
                collected_boxes = 0
                continue

            # Collision box line  e.g.  Clsn2[0] = x1, y1, x2, y2
            m = self._BOX_RE.match(line)
            if m and collecting_clsn is not None:
                box = CollisionBox(
                    int(m.group(1)), int(m.group(2)),
                    int(m.group(3)), int(m.group(4))
                )
                if collecting_clsn == 1:
                    pending_clsn1.append(box)
                else:
                    pending_clsn2.append(box)
                collected_boxes += 1
                if collected_boxes >= expected_boxes:
                    collecting_clsn = None
                continue

            # Frame data line  e.g.  0, 5, 0, 0, 3
            m = self._FRAME_RE.match(line)
            if m:
                frame = AnimFrame(
                    group=int(m.group(1)),
                    sprite=int(m.group(2)),
                    x_offset=int(m.group(3)),
                    y_offset=int(m.group(4)),
                    duration=int(m.group(5)),
                    clsn1=list(pending_clsn1),
                    clsn2=list(pending_clsn2),
                    is_loop_start=loop_flag,
                )
                current_action.frames.append(frame)
                # Reset pending boxes and flags for the next frame
                pending_clsn1, pending_clsn2 = [], []
                collecting_clsn = None
                loop_flag = False
                continue

    # ------------------------------------------------------------------
    # Convenience accessors
    # ------------------------------------------------------------------

    def get_action(self, action_id: int) -> Optional[Action]:
        return self.actions.get(action_id)

    def get_actions_with_attack_boxes(self) -> list[Action]:
        return [a for a in self.actions.values()
                if any(f.clsn1 for f in a.frames)]


# ===========================================================================
# Utility / demo
# ===========================================================================

def parse_character(cns_path: str, air_path: str) -> dict:
    """
    High-level helper: parse both files and return a combined dict.

    Returns
    -------
    {
        "data"     : dict,           # [Data] section
        "size"     : dict,
        "velocity" : dict,
        "movement" : dict,
        "statedefs": { id: StateDef.to_dict(), … },
        "actions"  : { id: Action.to_dict(),   … },
    }
    """
    cns = CNSParser().parse_file(cns_path)
    air = AIRParser().parse_file(air_path)

    return {
        "data":      cns.get_section("data"),
        "size":      cns.get_section("size"),
        "velocity":  cns.get_section("velocity"),
        "movement":  cns.get_section("movement"),
        "statedefs": {sid: sd.to_dict() for sid, sd in cns.statedefs.items()},
        "actions":   {aid: a.to_dict()  for aid,  a in air.actions.items()},
    }


# ===========================================================================
# CLI demo
# ===========================================================================

if __name__ == "__main__":
    import json
    import sys

    if len(sys.argv) < 3:
        print("Usage: python mugen_parser.py <path/to/char.cns> <path/to/char.air>")
        sys.exit(1)

    cns_path, air_path = sys.argv[1], sys.argv[2]

    print("=== Parsing CNS ===")
    cns = CNSParser().parse_file(cns_path)

    print(f"  Statedefs found : {len(cns.statedefs)}")
    print(f"  Attack states   : {len(cns.get_attack_states())}")
    print(f"  HitDefs found   : {len(cns.get_hitdefs())}")

    print("\n--- Sample: [Data] section ---")
    print(json.dumps(cns.get_section("data"), indent=2))

    print("\n--- Sample: first attack HitDef ---")
    hitdefs = cns.get_hitdefs()
    if hitdefs:
        sid, hd = hitdefs[0]
        print(f"  State {sid}: {json.dumps(hd.to_dict(), indent=2)}")

    print("\n=== Parsing AIR ===")
    air = AIRParser().parse_file(air_path)

    print(f"  Actions found             : {len(air.actions)}")
    print(f"  Actions with attack boxes : {len(air.get_actions_with_attack_boxes())}")

    print("\n--- Sample: Action 200 frames ---")
    a200 = air.get_action(200)
    if a200:
        print(json.dumps(a200.to_dict(), indent=2))
    else:
        # fallback: first action
        first = next(iter(air.actions.values()))
        print(f"  (Action 200 not found, showing Action {first.action_id})")
        print(json.dumps(first.to_dict(), indent=2))
