import re
import shutil
from datetime import datetime

TARGET_WINRATE = 0.50
ADJUSTMENT_THRESHOLD = 0.03   # only touch characters outside this band
FEATURE_TO_MOVE_FIELD = {
    "startup_mean":   ("air",  "startup"),
    "damage_mean":    ("cns",  "damage"),
    "active_mean":    ("air",  "active"),
    "recovery_mean":  ("air",  "recovery"),
    "hit_stun_mean":  ("cns",  "hit_stun"),
    "guard_stun_mean":("cns",  "guard_stun"),
}

import pandas as pd
import numpy as np
from pathlib import Path
from extract_moves import extract_moves

CHARS_DIR  = Path("chars")
WINRATE_CSV = Path("ML_data/win_rates.csv")

# Map CSV character names → chars/ folder names (add entries as needed)
CSV_TO_FOLDER = {
    "gouki_normal": "Akuma",
    "blanka":       "Blanka",
    "cammy":        "Cammy",
    "feilong":      "Fei-Long",
    "ken":          "Ken",
    "ryu":          "Ryu",
    "sagat":        "Sagat",
    # "vega": "M.Bison",  # excluded — no single AI.cns file
}

def load_winrates(csv_path: Path = WINRATE_CSV) -> dict:
    """Read win_rates.csv matrix and return {folder_name: win_rate}."""
    df = pd.read_csv(csv_path, index_col=0)
    winrates = {}
    for char in df.index:
        wins   = df.loc[char].sum()
        losses = df[char].sum()
        total  = wins + losses
        rate   = wins / total if total > 0 else 0.0
        folder = CSV_TO_FOLDER.get(char.lower())
        if folder:
            winrates[folder] = round(rate, 4)
        else:
            print(f"Warning: no folder mapping for '{char}', skipping")
    return winrates

WINRATES = load_winrates()

def load_character_moves(char_name: str) -> pd.DataFrame:
    char_dir = CHARS_DIR / char_name
    cns_files = list(char_dir.glob("*-AI.cns"))
    air_files = list(char_dir.glob("*.air"))
    if not cns_files:
        return pd.DataFrame()
    moves = extract_moves(cns_files[0], air_files[0] if air_files else None)
    return pd.DataFrame(moves)

def aggregate_movelist(df: pd.DataFrame) -> dict:
    if df.empty:
        return {}

    features = {}

    # --- Move count ---
    features["move_count"] = len(df)

    # --- Numeric fields: mean, min, max, std ---
    numeric_cols = ["startup", "active", "recovery", "total_frames",
                    "hit_stun", "guard_stun", "juggle"]
    for col in numeric_cols:
        vals = pd.to_numeric(df[col], errors="coerce").dropna()
        features[f"{col}_mean"] = vals.mean()
        features[f"{col}_min"]  = vals.min()
        features[f"{col}_max"]  = vals.max()
        features[f"{col}_std"]  = vals.std()

    # --- Damage: strip expressions, keep numeric part ---
    damage_vals = (
        df["damage"]
        .str.extract(r"(\d+)", expand=False)
        .astype(float)
        .dropna()
    )
    features["damage_mean"] = damage_vals.mean()
    features["damage_max"]  = damage_vals.max()
    features["damage_std"]  = damage_vals.std()

    # --- Boolean fields: proportion ---
    features["aerial_ratio"]    = df["is_aerial"].mean()
    features["multi_hit_ratio"] = df["multi_hit"].mean()

    # --- Categorical: proportion of each known category ---
    hit_types  = ["High", "Low", "Trip"]
    attributes = ["NA", "SA", "HA", "NP", "SP", "HP"]   # MUGEN attack attrs

    for ht in hit_types:
        features[f"hit_type_{ht}"] = (
            df["hit_type"].str.upper() == ht.upper()
        ).mean()

    for attr in attributes:
        features[f"attr_{attr}"] = df["attribute"].str.contains(
            attr, case=False, na=False
        ).mean()

    return features


def get_adjustment_plan(shap_values, X, y, feature_names):
    """
    Returns per-character: direction (buff/nerf) and which features to adjust.
    """
    plans = {}
    shap_df = pd.DataFrame(shap_values, index=X.index, columns=feature_names)

    for char in X.index:
        gap = TARGET_WINRATE - y[char]   # positive = needs buff, negative = needs nerf

        if abs(gap) < ADJUSTMENT_THRESHOLD:
            continue   # already balanced

        # Features pushing winrate in the wrong direction (making imbalance worse)
        row = shap_df.loc[char]
        if gap > 0:
            # underperforming — find features with most negative SHAP
            culprits = row[row < 0].sort_values().head(3)
        else:
            # overperforming — find features with most positive SHAP
            culprits = row[row > 0].sort_values(ascending=False).head(3)

        plans[char] = {
            "winrate": y[char],
            "gap": gap,
            "direction": "buff" if gap > 0 else "nerf",
            "features": culprits.to_dict(),
        }

    return plans

def select_moves_to_adjust(moves_df, feature, direction):
    """
    For a given aggregate feature (e.g. 'startup_mean'),
    return the individual move state_ids that should be adjusted.

    For a nerf: target moves with the HIGHEST values (outliers pulling average up).
    For a buff: target moves with the LOWEST values (outliers pulling average down).
    """
    col = feature.replace("_mean", "").replace("_max", "").replace("_min", "")
    if col not in moves_df.columns:
        return []

    if col == "damage":
        vals = pd.to_numeric(moves_df[col], errors="coerce").dropna()
    else:
        vals = pd.to_numeric(moves_df[col], errors="coerce").dropna()

    if vals.empty:
        return []

    if direction == "nerf":
        targets = vals.nlargest(3).index
    else:
        targets = vals.nsmallest(3).index

    return moves_df.loc[targets, "state_id"].tolist()

# How aggressively to adjust per 1% winrate gap
SCALING = {
    "startup":  0.5,    # frames per 1% gap
    "damage":   0.03,   # multiplier per 1% gap  e.g. gap=6% → ×1.18
    "recovery": 0.5,
    "hit_stun": 0.3,
}

# Fields where a LOWER value means STRONGER — so buff/nerf direction is inverted.
#   startup:  fewer frames before hitbox = faster = stronger
#   recovery: fewer frames after hitbox  = less punishable = stronger
INVERSE_FIELDS = {"startup", "recovery"}

def compute_adjustment(field, current_value, gap_pct, direction):
    """
    Returns the new value after adjustment.
    gap_pct: absolute winrate gap * 100  (e.g. 6 for a 6% gap)

    For inverse fields (startup, recovery), the adjustment direction is flipped:
      nerf  → increase value  (slower startup / longer recovery = weaker)
      buff  → decrease value  (faster startup / shorter recovery = stronger)
    """
    scale = SCALING.get(field, 0.03)

    if field in INVERSE_FIELDS:
        direction = "nerf" if direction == "buff" else "buff"

    if field == "damage":
        factor = 1 + (scale * gap_pct * (1 if direction == "buff" else -1))
        factor = max(0.7, min(1.3, factor))    # cap at ±30%
        return round(current_value * factor)
    else:
        delta = round(scale * gap_pct) * (1 if direction == "buff" else -1)
        new_val = current_value + delta
        return max(1, new_val)    # frames can't go below 1

def adjust_cns_field(cns_path, state_id, field, new_val):
    """Set a plain-integer HitDef field (e.g. guard_stun, hit_stun) in a Statedef block."""
    FIELD_PARAM = {
        "hit_stun":   r"ground\.hittime",
        "guard_stun": r"guard\.ctrltime",
    }
    param_re = FIELD_PARAM.get(field, re.escape(field))
    new_val  = max(1, int(round(float(new_val))))

    text    = Path(cns_path).read_text(encoding="utf-8", errors="replace")
    pattern = rf"(\[Statedef\s+{state_id}\].*?)(?=\[Statedef|\Z)"
    block_m = re.search(pattern, text, re.DOTALL | re.IGNORECASE)
    if not block_m:
        return False

    old_block = block_m.group(1)

    def replace_field(m):
        raw = m.group(1).split(";")[0].strip()
        if re.fullmatch(r"-?\d+", raw):
            return m.group(0).replace(m.group(1), str(new_val))
        return m.group(0)

    new_block = re.sub(
        rf"\b{param_re}\s*=\s*([^\n]+)",
        replace_field, old_block, flags=re.IGNORECASE,
    )
    if new_block == old_block:
        return False
    Path(cns_path).write_text(text.replace(old_block, new_block), encoding="utf-8")
    return True


def adjust_air_frame(air_path, anim_id, field, new_val):
    """
    Adjust startup, active, or recovery for an action in a .air file by
    modifying one frame's duration:
      startup  → last pre-hitbox frame
      active   → last hitbox frame
      recovery → first post-hitbox frame
    """
    new_val  = max(1, int(round(float(new_val))))
    air_path = Path(air_path)
    text     = air_path.read_text(encoding="utf-8", errors="replace")
    lines    = text.splitlines(keepends=True)

    action_re      = re.compile(rf"^\s*\[Begin Action\s+{anim_id}\]", re.IGNORECASE)
    next_action_re = re.compile(r"^\s*\[Begin Action", re.IGNORECASE)
    frame_re       = re.compile(r"^(\s*\d+\s*,\s*\d+\s*,\s*-?\d+\s*,\s*-?\d+\s*,\s*)(-?\d+)(.*)")
    clsn1_re       = re.compile(r"^\s*Clsn1\s*:", re.IGNORECASE)

    # Locate action block
    start = None
    for i, ln in enumerate(lines):
        if action_re.match(ln):
            start = i + 1
            break
    if start is None:
        print(f"    [AIR] Action {anim_id} not found")
        return False

    end = len(lines)
    for i in range(start, len(lines)):
        if next_action_re.match(lines[i]):
            end = i
            break

    # Classify frames
    frames        = []   # {line_idx, has_clsn1, duration}
    pending_clsn1 = False
    for i in range(start, end):
        s = lines[i].strip()
        if clsn1_re.match(s):
            pending_clsn1 = True
        elif frame_re.match(s):
            m   = frame_re.match(s)
            dur = int(m.group(2))
            frames.append({"idx": i, "has_clsn1": pending_clsn1, "duration": max(1, dur)})
            pending_clsn1 = False

    hitbox_pos = [j for j, f in enumerate(frames) if f["has_clsn1"]]
    if not hitbox_pos:
        print(f"    [AIR] Action {anim_id}: no hitbox frames, cannot adjust {field}")
        return False

    first_hit, last_hit = hitbox_pos[0], hitbox_pos[-1]
    pre   = frames[:first_hit]
    hits  = frames[first_hit:last_hit + 1]
    post  = frames[last_hit + 1:]

    # Pick target frame and compute delta
    if field == "startup":
        if not pre:
            print(f"    [AIR] Action {anim_id}: no pre-hitbox frames")
            return False
        current = sum(f["duration"] for f in pre) + 1
        target  = pre[-1]
    elif field == "active":
        current = sum(f["duration"] for f in hits)
        target  = hits[-1]
    elif field == "recovery":
        if not post:
            print(f"    [AIR] Action {anim_id}: no recovery frames")
            return False
        current = sum(f["duration"] for f in post)
        target  = post[0]
    else:
        return False

    delta   = new_val - current
    old_dur = target["duration"]
    new_dur = max(1, old_dur + delta)

    m = frame_re.match(lines[target["idx"]])
    if not m:
        return False
    lines[target["idx"]] = m.group(1) + str(new_dur) + m.group(3)
    air_path.write_text("".join(lines), encoding="utf-8")
    print(f"    [AIR] Action {anim_id}: {field} {current} → {new_val}  (frame dur {old_dur} → {new_dur})")
    return True


def adjust_cns_damage(cns_path, state_id, multiplier):
    """Scale the damage value in a specific Statedef's HitDef."""
    text = Path(cns_path).read_text(encoding="utf-8", errors="replace")

    # Isolate the Statedef block
    pattern = rf"(\[Statedef\s+{state_id}\].*?)(?=\[Statedef|\Z)"
    block_m = re.search(pattern, text, re.DOTALL | re.IGNORECASE)
    if not block_m:
        return

    old_block = block_m.group(1)

    def replace_damage(m):
        from extract_moves import BASE_DMG_RE, extract_base_damage
        full_line = m.group(1)   # everything after "damage = " on that line
        # Skip multi-hit lines
        if ',' in full_line.split(';')[0]:
            return m.group(0)
        current   = extract_base_damage(full_line)
        if current is None:
            return m.group(0)   # unparseable — leave untouched
        new_coeff = max(1, round(current * multiplier))

        coeff_m = BASE_DMG_RE.search(full_line)
        if coeff_m:
            # Replace only the coefficient inside the ceil(...) expression
            new_line = (full_line[:coeff_m.start(1)]
                        + str(new_coeff)
                        + full_line[coeff_m.end(1):])
        else:
            # Plain integer — replace the whole value
            new_line = re.sub(r'\d+', str(new_coeff), full_line, count=1)

        return m.group(0).replace(full_line, new_line)

    new_block = re.sub(
        r"\bdamage\s*=\s*([^\n]+)", replace_damage, old_block, flags=re.IGNORECASE
    )
    Path(cns_path).write_text(
        text.replace(old_block, new_block), encoding="utf-8"
    )

def backup_files(cns_path: Path, air_path: Path = None) -> Path:
    """
    Copy the original .cns (and .air if present) to
    chars/<char>/backups/<timestamp>/.
    Returns the backup directory path.
    """
    timestamp  = datetime.now().strftime("%Y%m%d_%H%M%S")
    backup_dir = cns_path.parent / "backups" / timestamp
    backup_dir.mkdir(parents=True, exist_ok=True)
    shutil.copy2(cns_path, backup_dir / cns_path.name)
    print(f"  Backup saved: {backup_dir / cns_path.name}")
    if air_path and Path(air_path).exists():
        shutil.copy2(air_path, backup_dir / Path(air_path).name)
        print(f"  Backup saved: {backup_dir / Path(air_path).name}")
    return backup_dir


def update_def_cns(char_dir: Path, old_cns_name: str, new_cns_name: str) -> None:
    """Rewrite the cns/st line(s) in every .def in char_dir to point to new_cns_name."""
    for def_path in char_dir.glob("*.def"):
        text    = def_path.read_text(encoding="utf-8", errors="replace")
        patched = re.sub(
            rf'(?m)(^\s*(?:cns|st)\s*=\s*){re.escape(old_cns_name)}',
            rf'\g<1>{new_cns_name}',
            text, flags=re.IGNORECASE,
        )
        if patched != text:
            def_path.write_text(patched, encoding="utf-8")
            print(f"  Updated def: {def_path.name}  cns -> {new_cns_name}")


def restore_from_backup(char_dir: Path, timestamp: str = None) -> None:
    """
    Restore a character's .cns and .air files from a backup snapshot and
    update every .def in char_dir to reference the restored filenames.

    Parameters
    ----------
    char_dir  : Path to the character folder (e.g. chars/Ryu)
    timestamp : Backup folder name (e.g. "20240101_120000").
                If None, the most-recent backup is used.

    Backup layout expected:
        chars/<char>/backups/<timestamp>/<original>.cns
        chars/<char>/backups/<timestamp>/<original>.air   (optional)
    """
    char_dir   = Path(char_dir)
    backup_root = char_dir / "backups"

    if not backup_root.exists():
        print(f"  [RESTORE] No backup directory found at {backup_root}")
        return

    # Pick backup snapshot
    snapshots = sorted(backup_root.iterdir())          # ascending → latest last
    if not snapshots:
        print(f"  [RESTORE] No snapshots found in {backup_root}")
        return

    if timestamp:
        snap_dir = backup_root / timestamp
        if not snap_dir.exists():
            print(f"  [RESTORE] Snapshot '{timestamp}' not found in {backup_root}")
            print(f"  Available snapshots: {[s.name for s in snapshots]}")
            return
    else:
        snap_dir = snapshots[-1]   # most recent

    print(f"  [RESTORE] Using snapshot: {snap_dir.name}")

    restored_cns = None

    for src in snap_dir.iterdir():
        dest = char_dir / src.name
        shutil.copy2(src, dest)
        print(f"  [RESTORE] {src.name}  →  {dest}")

        if src.suffix.lower() == ".cns":
            restored_cns = src.name

    # Re-point every .def to the restored .cns name.
    # Rewrites ANY cns/st = ... line regardless of what it currently says.
    if restored_cns:
        for def_path in char_dir.glob("*.def"):
            text = def_path.read_text(encoding="utf-8", errors="replace")
            patched = re.sub(
                r'(?mi)(^\s*(?:cns|st)\s*=\s*)\S+',
                rf'\g<1>{restored_cns}',
                text,
            )
            if patched != text:
                def_path.write_text(patched, encoding="utf-8")
                print(f"  [RESTORE] Updated def: {def_path.name}  →  cns = {restored_cns}")

    print(f"  [RESTORE] Done — {char_dir.name} restored to snapshot {snap_dir.name}")


def auto_balance(cns_path, air_path, shap_values, X, y,
                 dry_run: bool = False) -> dict:
    """
    Run balancing for one character.
    Returns a report dict for write_report().

    dry_run=True  →  compute and report changes but write nothing to disk.
    """
    cns_path = Path(cns_path)
    air_path = Path(air_path) if air_path else None

    plans    = get_adjustment_plan(shap_values, X, y, X.columns.tolist())
    char     = cns_path.parent.name
    plan_key = X.index[0]

    report = {
        "character":    char,
        "win_rate":     float(y.iloc[0]),
        "gap":          float(TARGET_WINRATE - y.iloc[0]),
        "direction":    None,
        "shap_reasons": {},
        "changes":      [],
        "skipped":      [],
        "balanced_cns": None,
        "action":       "already_balanced",
    }

    if plan_key not in plans:
        win_rate = y.iloc[0]
        gap      = TARGET_WINRATE - win_rate
        print(f"  Already balanced  (win rate {win_rate:.1%}, gap {gap:+.1%} within ±{ADJUSTMENT_THRESHOLD:.0%})")
        return report

    plan    = plans[plan_key]
    gap_pct = abs(plan["gap"]) * 100
    report["direction"]    = plan["direction"]
    report["shap_reasons"] = plan["features"]
    report["action"]       = plan["direction"]

    print(f"  Win rate : {plan['winrate']:.1%}  →  {plan['direction'].upper()}  (gap {plan['gap']:+.1%})")
    print(f"  Top culprit features:")
    for feature, shap_val in plan["features"].items():
        print(f"    {feature:<22}  SHAP={shap_val:+.4f}")

    base_stem    = re.sub(r"(-balanced)+$", "", cns_path.stem, flags=re.IGNORECASE)
    balanced_cns = cns_path.with_stem(base_stem + "-balanced")

    if dry_run:
        print(f"  [DRY RUN] Would write: {balanced_cns.name}")
    else:
        backup_files(cns_path, air_path)
        if cns_path.resolve() != balanced_cns.resolve():
            shutil.copy2(cns_path, balanced_cns)
    report["balanced_cns"] = str(balanced_cns)
    print(f"  Balanced CNS : {balanced_cns.name}")

    src_cns  = cns_path if dry_run else balanced_cns
    moves_df = pd.DataFrame(extract_moves(src_cns, air_path))
    print(f"  Moves loaded : {len(moves_df)} attack states")

    adjustments_made = 0
    for feature, shap_val in plan["features"].items():
        if feature not in FEATURE_TO_MOVE_FIELD:
            print(f"  [SKIP feature] {feature}: not in FEATURE_TO_MOVE_FIELD")
            report["skipped"].append((feature, "not in FEATURE_TO_MOVE_FIELD"))
            continue

        file_type, move_field = FEATURE_TO_MOVE_FIELD[feature]
        state_ids = select_moves_to_adjust(moves_df, feature, plan["direction"])

        if not state_ids:
            print(f"  [SKIP feature] {feature}: no target states found")
            report["skipped"].append((feature, "no target states found"))
            continue

        print(f"  {feature}  →  adjusting '{move_field}' on states {state_ids}")
        for sid in state_ids:
            row     = moves_df[moves_df["state_id"] == sid].iloc[0]
            current = row.get(move_field)
            if current is None or (isinstance(current, float) and np.isnan(current)):
                print(f"    State {sid}: '{move_field}' not present, skipping")
                continue

            new_val = compute_adjustment(move_field, float(current), gap_pct, plan["direction"])
            tag     = "[DRY RUN] Would set" if dry_run else ""
            print(f"    State {sid}: {move_field}  {current}  →  {new_val}  {tag}".rstrip())

            if dry_run:
                written = True   # count as would-be change
            elif file_type == "cns" and move_field == "damage":
                multiplier = new_val / float(current)
                adjust_cns_damage(balanced_cns, sid, multiplier)
                written = True
            elif file_type == "cns":
                written = adjust_cns_field(balanced_cns, sid, move_field, new_val)
            elif file_type == "air" and air_path:
                anim_id = row.get("anim_id", sid)
                written = adjust_air_frame(air_path, int(anim_id), move_field, new_val)
            else:
                written = False

            if written:
                adjustments_made += 1
                report["changes"].append({
                    "feature":   feature,
                    "shap":      shap_val,
                    "state_id":  sid,
                    "field":     move_field,
                    "old_val":   float(current),
                    "new_val":   new_val,
                })

    label = "Would adjust" if dry_run else "Adjustments written"
    print(f"  {label} : {adjustments_made}")
    if not dry_run:
        update_def_cns(cns_path.parent, cns_path.name, balanced_cns.name)
    return report


def write_report(entries: list, timestamp: str, nash: dict = None) -> Path:
    """Write a human-readable balance report to ML_data/balance_report_<timestamp>.txt"""
    W  = 62   # total line width
    HR = "─" * W

    lines = []
    def ln(s=""):  lines.append(s)

    ln("=" * W)
    ln("  ROSTER BALANCE REPORT")
    ln(f"  {datetime.now().strftime('%Y-%m-%d  %H:%M:%S')}")
    ln("=" * W)
    ln()
    ln(f"  Target win rate  :  {TARGET_WINRATE:.0%}")
    ln(f"  Adjustment band  :  ±{ADJUSTMENT_THRESHOLD:.0%}")
    ln(f"  Characters processed  :  {len(entries)}")
    ln()

    # --- Summary table ---
    ln("WIN RATE SUMMARY")
    ln(HR)
    ln(f"  {'Character':<14}{'Win Rate':>10}{'Gap':>10}    Action")
    ln(f"  {'─'*14}{'─'*10}{'─'*10}    {'─'*8}")
    for e in sorted(entries, key=lambda x: x["win_rate"], reverse=True):
        if e["action"] == "already_balanced":
            action = "OK  ✓"
        elif e["action"] == "buff":
            action = "BUFF ↑"
        else:
            action = "NERF ↓"
        ln(f"  {e['character']:<14}{e['win_rate']:>9.1%}{e['gap']:>+10.1%}    {action}")
    ln()

    # --- Per-character detail ---
    for e in entries:
        char      = e["character"]
        direction = (e["direction"] or "balanced").upper()
        ln(HR)
        ln(f"  {char.upper():<40} [{direction}]")
        ln(HR)
        ln(f"  Win rate  :  {e['win_rate']:.1%}   (gap  {e['gap']:+.1%})")

        if e["action"] == "already_balanced":
            ln(f"  Status    :  Within ±{ADJUSTMENT_THRESHOLD:.0%} band — no changes needed.")
            ln()
            continue

        ln(f"  Output    :  {Path(e['balanced_cns']).name}")
        ln()

        # SHAP reasons
        ln("  Why these changes?  (SHAP contribution to win rate)")
        ln(f"  {'Feature':<24}  {'SHAP':>8}   Interpretation")
        ln(f"  {'─'*24}  {'─'*8}   {'─'*28}")
        for feat, shap_val in e["shap_reasons"].items():
            direction_word = "over-performing" if shap_val > 0 else "under-performing"
            ln(f"  {feat:<24}  {shap_val:>+8.4f}   pushing character {direction_word}")
        ln()

        if e["skipped"]:
            ln("  Skipped features:")
            for feat, reason in e["skipped"]:
                ln(f"    {feat:<24}  ({reason})")
            ln()

        if e["changes"]:
            ln(f"  Changes applied  ({len(e['changes'])} total)")
            ln(f"  {'State':>7}  {'Field':<14}  {'Old':>6}  {'New':>6}  {'SHAP Driver':<24}")
            ln(f"  {'─'*7}  {'─'*14}  {'─'*6}  {'─'*6}  {'─'*24}")
            for c in e["changes"]:
                ln(f"  {c['state_id']:>7}  {c['field']:<14}  {c['old_val']:>6.1f}  {c['new_val']:>6.1f}  {c['feature']:<24}")
        else:
            ln("  No changes were written  (all features skipped or unwritable).")
        ln()

    # --- Matchup Matrix ---
    if nash is not None:
        chars    = nash["characters"]
        P_rate   = nash["P_rate"]
        col_w    = 8
        name_w   = 14

        ln("=" * W)
        ln("  MATCHUP MATRIX  (row wins vs col,  proportion 0-1)")
        ln("=" * W)

        # Header row
        header = f"  {'':>{name_w}}"
        for c in chars:
            header += f"  {c[:col_w]:>{col_w}}"
        ln(header)
        ln(f"  {'─'*name_w}" + f"  {'─'*col_w}" * len(chars))

        for i, row_char in enumerate(chars):
            row_str = f"  {row_char:<{name_w}}"
            for j in range(len(chars)):
                if i == j:
                    cell = "   —   "
                else:
                    cell = f"{P_rate[i, j]:.3f}"
                row_str += f"  {cell:>{col_w}}"
            ln(row_str)
        ln()

        # --- Nash Equilibrium ---
        ln("=" * W)
        ln("  NASH EQUILIBRIUM MIXED STRATEGY")
        ln("=" * W)
        ln(f"  Expected game value (v*)  :  {nash['v_star']:+.4f}")
        ln()
        ln(f"  {'Character':<{name_w}}  {'p*':>8}  {'Win Rate':>10}")
        ln(f"  {'─'*name_w}  {'─'*8}  {'─'*10}")
        paired = sorted(
            zip(chars, nash["p_star"], [nash["win_rates"].get(c, 0.0) for c in chars]),
            key=lambda t: t[1],
            reverse=True,
        )
        for char, p, wr in paired:
            ln(f"  {char:<{name_w}}  {p:>8.4f}  {wr:>10.1%}")
        ln()

        if nash.get("status", 0) != 0:
            ln(f"  ⚠  LP solver warning: {nash['message']}")
            ln()

    ln("=" * W)
    ln("  END OF REPORT")
    ln("=" * W)

    out_dir  = Path("ML_data")
    out_dir.mkdir(exist_ok=True)
    out_path = out_dir / f"balance_report_{timestamp}.txt"
    out_path.write_text("\n".join(lines), encoding="utf-8")
    return out_path


# Reverse of CSV_TO_FOLDER: lowercase csv name → folder name
# (built lazily so CSV_TO_FOLDER is defined first)
def _folder_to_csv():
    return {v.lower(): k for k, v in CSV_TO_FOLDER.items()}


def _active_cns_from_def(char_dir: Path) -> Path | None:
    """
    Read the first .def file in char_dir and return the Path of the .cns
    file currently referenced by its 'cns =' (or 'st =') line.
    Returns None if no .def or no cns line is found.
    """
    for def_path in char_dir.glob("*.def"):
        text = def_path.read_text(encoding="utf-8", errors="replace")
        m    = re.search(r'^\s*(?:cns|st)\s*=\s*(\S+)', text,
                         re.IGNORECASE | re.MULTILINE)
        if m:
            return char_dir / m.group(1)
    return None


def main():
    import argparse
    parser = argparse.ArgumentParser(description="MUGEN/Ikemen GO roster balancer")
    parser.add_argument(
        "--dry-run", "-n", action="store_true",
        help="Compute and report changes without writing any files.",
    )
    args = parser.parse_args()
    dry_run = args.dry_run

    from SHAP import compute_shap

    print("=" * 60)
    print("  ROSTER BALANCER" + ("  [DRY RUN]" if dry_run else ""))
    print("=" * 60)
    print(f"\nTarget win rate : {TARGET_WINRATE:.0%}")
    print(f"Adjustment band : ±{ADJUSTMENT_THRESHOLD:.0%}  (characters within this range are skipped)")
    print(f"\nComputing SHAP values from match data...")
    explainer, shap_values, X, y = compute_shap()
    print(f"  Model trained on {len(X)} characters, {X.shape[1]} features")

    print(f"\nWin rates loaded:")
    for char, wr in sorted(WINRATES.items(), key=lambda x: x[1], reverse=True):
        gap    = TARGET_WINRATE - wr
        status = "OK" if abs(gap) < ADJUSTMENT_THRESHOLD else ("BUFF ↑" if gap > 0 else "NERF ↓")
        print(f"  {char:<12}  {wr:.1%}  (gap {gap:+.1%})  [{status}]")

    csv_name_of = _folder_to_csv()
    total       = len(WINRATES)
    timestamp   = datetime.now().strftime("%Y%m%d_%H%M%S")
    report_entries: list = []
    print(f"\nProcessing {total} characters...\n")

    for i, folder_name in enumerate(WINRATES, 1):
        print(f"[{i}/{total}] {folder_name}")
        char_dir = CHARS_DIR / folder_name

        cns_path = _active_cns_from_def(char_dir)
        if cns_path is None or not cns_path.exists():
            print(f"  [SKIP] could not resolve active .cns from .def in {char_dir}")
            continue

        # Match the .air by same stem as the active .cns, fall back to any .air
        air_path = cns_path.with_suffix(".air")
        if not air_path.exists():
            air_files = list(char_dir.glob("*.air"))
            air_path  = air_files[0] if air_files else None

        csv_key = csv_name_of.get(folder_name.lower())
        if csv_key is None or csv_key not in X.index:
            print(f"  [SKIP] '{folder_name}' not found in SHAP data (csv key: {csv_key!r})")
            continue

        print(f"  CNS  : {cns_path.name}  (from .def)")
        print(f"  AIR  : {air_path.name if air_path else 'none'}")

        X_char  = X.loc[[csv_key]]
        y_char  = y.loc[[csv_key]]
        sv_char = shap_values[[X.index.get_loc(csv_key)]]

        entry = auto_balance(
            cns_path    = cns_path,
            air_path    = air_path,
            shap_values = sv_char,
            X           = X_char,
            y           = y_char,
            dry_run     = dry_run,
        )
        if entry:
            report_entries.append(entry)

    # --- Nash equilibrium ---
    print("\nComputing Nash equilibrium...")
    try:
        from nashEquilibrium import compute_nash
        nash = compute_nash(str(WINRATE_CSV))
        if nash["status"] == 0:
            print("  Equilibrium mixed strategy (p*):")
            for char, p in sorted(zip(nash["characters"], nash["p_star"]),
                                   key=lambda t: t[1], reverse=True):
                print(f"    {char:<14}  {p:.4f}")
            print(f"  Expected game value (v*): {nash['v_star']:+.4f}")
        else:
            print(f"  ⚠  LP solver warning: {nash['message']}")
    except Exception as exc:
        print(f"  [WARN] Nash equilibrium failed: {exc}")
        nash = None

    report_path = write_report(report_entries, timestamp + ("_dryrun" if dry_run else ""), nash=nash)
    print(f"\n  Report saved : {report_path}")
    print("\n" + "=" * 60)
    print("  Done.")
    print("=" * 60)


if __name__ == "__main__":
    main()