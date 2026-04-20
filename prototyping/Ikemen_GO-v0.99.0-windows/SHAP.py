import pandas as pd
import numpy as np
import shap
import matplotlib.pyplot as plt
from sklearn.ensemble import GradientBoostingRegressor
from pathlib import Path
import re


CSV_PATH = "ML_data/win_rates_placeHolder2.csv"

# ---------------------------------------------------------------------------
# Damage normalisation — evaluate var(52)=3 (base scaling)
# ---------------------------------------------------------------------------
def eval_damage(expr: str) -> float | None:
    if not isinstance(expr, str) or not expr:
        return None
    # Replace var(52) with 3, then try to eval ceil(...)
    e = re.sub(r'var\(52\)', '3', expr, flags=re.IGNORECASE)
    e = re.sub(r'ceil\(([^)]+)\)', r'(\1)', e)   # replace ceil() with passthrough
    # Only keep the first damage value (before comma for multi-hit)
    e = e.split(',')[0]
    try:
        return float(eval(e, {"__builtins__": {}, "ifelse": lambda c,a,b: a if c else b}))
    except Exception:
        return None


# ---------------------------------------------------------------------------
# Aggregate one character's movelist CSV into a feature dict
# ---------------------------------------------------------------------------
def aggregate_movelist(csv_path: Path, char_name: str) -> dict:
    df = pd.read_csv(csv_path)

    df['damage_val'] = df['damage'].apply(eval_damage)
    df['is_special'] = df['attribute'].str.contains('SA', na=False)
    df['is_hyper']   = df['attribute'].str.contains('HA', na=False)
    df['is_low']     = df['hit_type'].str.lower() == 'low'
    df['is_high']    = df['hit_type'].str.lower() == 'high'

    def safe_mean(col): return df[col].dropna().mean() if col in df else np.nan
    def safe_min(col):  return df[col].dropna().min()  if col in df else np.nan
    def safe_max(col):  return df[col].dropna().max()  if col in df else np.nan
    def safe_std(col):  return df[col].dropna().std()  if col in df else np.nan

    return {
        'character':         char_name,
        'dmg_mean':          safe_mean('damage_val'),
        'dmg_max':           safe_max('damage_val'),
        'dmg_std':           safe_std('damage_val'),
        'startup_mean':      safe_mean('startup'),
        'startup_min':       safe_min('startup'),
        'startup_std':       safe_std('startup'),
        'recovery_mean':     safe_mean('recovery'),
        'recovery_max':      safe_max('recovery'),
        'active_mean':       safe_mean('active'),
        'active_max':        safe_max('active'),
        'hit_stun_mean':     safe_mean('hit_stun'),
        'guard_stun_mean':   safe_mean('guard_stun'),
        'total_frames_mean': safe_mean('total_frames'),
    }


def compute_win_rates(csv_path: str = CSV_PATH) -> pd.DataFrame:
    df = pd.read_csv(csv_path, index_col=0)

    results = []
    for char in df.index:
        wins   = df.loc[char].sum()   # row sum = wins for this char
        losses = df[char].sum()       # col sum = losses for this char
        total  = wins + losses
        rate   = wins / total if total > 0 else 0.0
        results.append({
            "character": char.lower(),
            "win_rate":  round(rate, 4),
        })

    return pd.DataFrame(results).sort_values("win_rate", ascending=False)


def main():
    move_csvs = list(Path("ML_data/moves").glob("*_moves.csv"))

    rows = []
    for csv_path in move_csvs:
        char_name = csv_path.stem.replace('_moves', '').lower()
        rows.append(aggregate_movelist(csv_path, char_name))

    features_df = pd.DataFrame(rows)
    winrates    = compute_win_rates()

    df = features_df.merge(winrates, on='character')
    # Exclude 'character' and the target — winrates now only has those two columns
    FEATURE_COLS = [c for c in df.columns if c not in ('character', 'win_rate')]

    X = df[FEATURE_COLS].fillna(0)
    y = df['win_rate']

    model = GradientBoostingRegressor(n_estimators=100, random_state=42)
    model.fit(X, y)

    explainer   = shap.TreeExplainer(model)
    shap_values = explainer.shap_values(X)

    # Global feature importance
    shap.summary_plot(shap_values, X, plot_type="bar", show=False)
    plt.tight_layout()
    plt.savefig("ML_data/shap_importance.png", dpi=150)
    plt.close()
    print("Saved ML_data/shap_importance.png")

    # Beeswarm / dependency plot
    shap.summary_plot(shap_values, X, show=False)
    plt.tight_layout()
    plt.savefig("ML_data/shap_summary.png", dpi=150)
    plt.close()
    print("Saved ML_data/shap_summary.png")

    # Per-character force plots saved as PNG
    plots_dir = Path("ML_data/shap_plots")
    plots_dir.mkdir(exist_ok=True)
    for i, char in enumerate(df['character']):
        print(f"\n--- {char} (win_rate={y.iloc[i]:.3f}) ---")
        shap.force_plot(
            explainer.expected_value, shap_values[i], X.iloc[i].round(3),
            matplotlib=True, show=False,
        )
        plt.savefig(plots_dir / f"{char}_force.png", bbox_inches='tight', dpi=150)
        plt.close()
        print(f"  Saved {plots_dir}/{char}_force.png")


if __name__ == "__main__":
    main()
