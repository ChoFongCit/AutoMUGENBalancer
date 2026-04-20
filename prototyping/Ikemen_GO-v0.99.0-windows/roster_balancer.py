import re

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
from sklearn.ensemble import GradientBoostingRegressor
from xgboost import XGBRegressor

# Winrates from your match runner results
# { character_name: winrate_0_to_1 }
WINRATES = {
    "Ryu":      0.61,
    "Ken":      0.55,
    "Zangief":  0.48,
    # ...
}

CHARS_DIR = Path("chars")

def load_character_moves(char_name: str) -> pd.DataFrame:
    char_dir = CHARS_DIR / char_name
    cns_files = list(char_dir.glob("*.cns"))
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

rows = []
for char_name, winrate in WINRATES.items():
    df_moves = load_character_moves(char_name)
    feats = aggregate_movelist(df_moves)
    feats["character"] = char_name
    feats["winrate"]   = winrate
    rows.append(feats)

data = pd.DataFrame(rows).set_index("character")
data = data.fillna(0)   # characters missing a category get 0

X = data.drop(columns=["winrate"])
y = data["winrate"]


model = XGBRegressor(
    n_estimators=100,
    max_depth=3,        # shallow — prevents overfitting on small datasets
    learning_rate=0.05,
    subsample=0.8,
    reg_alpha=0.1,
)
model.fit(X, y)

def get_adjustment_plan(shap_values, X, y, feature_names):
    """
    Returns per-character: direction (buff/nerf) and which features to adjust.
    """
    plans = {}
    shap_df = pd.DataFrame(shap_values.values, index=X.index, columns=feature_names)

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

    vals = pd.to_numeric(moves_df[col], errors="coerce").dropna()
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

def compute_adjustment(field, current_value, gap_pct, direction):
    """
    Returns the new value after adjustment.
    gap_pct: absolute winrate gap * 100  (e.g. 6 for a 6% gap)
    """
    scale = SCALING.get(field, 0.03)

    if field == "damage":
        factor = 1 + (scale * gap_pct * (1 if direction == "buff" else -1))
        factor = max(0.7, min(1.3, factor))    # cap at ±30%
        return round(current_value * factor)
    else:
        delta = round(scale * gap_pct) * (1 if direction == "buff" else -1)
        new_val = current_value + delta
        return max(1, new_val)    # frames can't go below 1

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
        raw = m.group(1).split(";")[0].strip()
        # Only replace if it's a plain integer (skip expressions like ceil(...))
        if re.fullmatch(r"\d+", raw):
            new_val = round(int(raw) * multiplier)
            return m.group(0).replace(m.group(1), str(new_val))
        return m.group(0)   # leave expressions untouched

    new_block = re.sub(
        r"\bdamage\s*=\s*([^\n]+)", replace_damage, old_block, flags=re.IGNORECASE
    )
    Path(cns_path).write_text(
        text.replace(old_block, new_block), encoding="utf-8"
    )
    
    def auto_balance(cns_path, air_path, shap_values, X, y):
    moves_df = pd.DataFrame(extract_moves(Path(cns_path), Path(air_path)))
    plans    = get_adjustment_plan(shap_values, X, y, X.columns.tolist())
    char     = Path(cns_path).parent.name

    if char not in plans:
        print(f"{char}: already balanced, skipping")
        return

    plan = plans[char]
    gap_pct = abs(plan["gap"]) * 100
    print(f"\n{char}: {plan['direction']} needed (gap={plan['gap']:+.2f})")

    for feature, shap_val in plan["features"].items():
        if feature not in FEATURE_TO_MOVE_FIELD:
            continue

        file_type, move_field = FEATURE_TO_MOVE_FIELD[feature]
        state_ids = select_moves_to_adjust(moves_df, feature, plan["direction"])
        print(f"  {feature} (SHAP={shap_val:+.3f}) → adjust {move_field} "
              f"on states {state_ids}")

        for sid in state_ids:
            row = moves_df[moves_df["state_id"] == sid].iloc[0]
            current = row.get(move_field)
            if current is None:
                continue

            new_val = compute_adjustment(
                move_field, float(current), gap_pct, plan["direction"]
            )
            print(f"    State {sid}: {move_field} {current} → {new_val}")

            if file_type == "cns" and move_field == "damage":
                multiplier = new_val / float(current)
                adjust_cns_damage(cns_path, sid, multiplier)