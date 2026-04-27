import numpy as np
import pandas as pd
from scipy.optimize import linprog

DEFAULT_CSV = "ML_data/win_rates.csv"


def compute_nash(csv_path: str = DEFAULT_CSV) -> dict:
    """
    Load a win-count matrix CSV, solve for the Nash equilibrium mixed strategy,
    and return a result dict:
        {
            "characters": [...],
            "p_star":     np.ndarray,   # equilibrium probabilities
            "v_star":     float,        # expected game value
            "win_rates":  {...},        # character -> win_rate (0-1)
            "status":     int,          # 0 = success
            "message":    str,
        }
    """
    df = pd.read_csv(csv_path, index_col=0)
    characters = df.index.tolist()
    max_usage  = df["MaxUsage"].to_numpy() if "MaxUsage" in df.columns else None

    # Convert raw win counts to a win-rate matrix (row = winner)
    P = df.loc[characters, characters].to_numpy(dtype=float)
    totals = P + P.T                            # total games per matchup
    with np.errstate(invalid="ignore"):
        P_rate = np.where(totals > 0, P / totals, 0.5)

    # Per-character overall win rate (for display)
    win_rates = {}
    for i, char in enumerate(characters):
        wins   = P[i].sum()
        losses = P[:, i].sum()
        total  = wins + losses
        win_rates[char] = wins / total if total > 0 else 0.0

    # === Build zero-sum payoff matrix ===
    A = P_rate - P_rate.T
    n = A.shape[0]

    # === Formulate LP ===
    c = np.zeros(n + 1)
    c[-1] = -1

    lhs_ineq = np.hstack([-A.T, np.ones((n, 1))])
    rhs_ineq = np.zeros(n)

    if max_usage is not None:
        usage_lhs = np.hstack([np.eye(n), np.zeros((n, 1))])
        lhs_ineq  = np.vstack([lhs_ineq, usage_lhs])
        rhs_ineq  = np.concatenate([rhs_ineq, max_usage])

    lhs_eq        = np.zeros((1, n + 1))
    lhs_eq[0, :n] = 1
    rhs_eq        = np.array([1.0])
    bounds        = [(0, None)] * n + [(None, None)]

    # === Solve LP ===
    res = linprog(c, A_ub=lhs_ineq, b_ub=rhs_ineq,
                  A_eq=lhs_eq, b_eq=rhs_eq,
                  bounds=bounds, method="highs")

    p_star = res.x[:n] if res.x is not None else np.zeros(n)
    v_star = float(res.x[-1]) if res.x is not None else 0.0

    return {
        "characters": characters,
        "p_star":     p_star,
        "v_star":     v_star,
        "win_rates":  win_rates,
        "P_rate":     P_rate,
        "status":     res.status,
        "message":    res.message,
    }


def print_nash(result: dict) -> None:
    print("Equilibrium mixed strategy (p*):")
    for name, p in zip(result["characters"], result["p_star"]):
        print(f"  {name:14s}: {p:.4f}")
    print(f"\nExpected game value (v*): {result['v_star']:.4f}")
    if result["status"] != 0:
        print(f"\n⚠️  Optimisation warning: {result['message']}")


if __name__ == "__main__":
    result = compute_nash()
    print_nash(result)
