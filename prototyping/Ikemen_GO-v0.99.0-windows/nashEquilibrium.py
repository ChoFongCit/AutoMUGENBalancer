import numpy as np
import pandas as pd
from scipy.optimize import linprog

# === Step 1: Load data ===
df = pd.read_csv("ML_data/win_rates_placeHolder2.csv")

characters = df["Character"].tolist()
max_usage = df["MaxUsage"].to_numpy() if "MaxUsage" in df.columns else None

# Extract the NxN matchup matrix using character names as both row and column selectors
P = df.set_index("Character").loc[characters, characters].to_numpy(dtype=float)

# === Step 2: Build zero-sum payoff matrix ===
A = P - P.T
n = A.shape[0]

# === Step 3: Formulate LP ===
# Objective: maximize v → minimize -v
c = np.zeros(n + 1)
c[-1] = -1

# Constraints: A^T p - v >= 0  →  -A^T p + v <= 0
lhs_ineq = np.hstack([-A.T, np.ones((n, 1))])
rhs_ineq = np.zeros(n)

# Add usage limits: p_i <= max_usage_i (only if provided)
if max_usage is not None:
    usage_lhs = np.hstack([np.eye(n), np.zeros((n, 1))])
    lhs_ineq  = np.vstack([lhs_ineq, usage_lhs])
    rhs_ineq  = np.concatenate([rhs_ineq, max_usage])

# Equality constraint: sum(p) = 1
lhs_eq = np.zeros((1, n + 1))
lhs_eq[0, :n] = 1
rhs_eq = np.array([1])

# Bounds: p_i >= 0, v free
bounds = [(0, None)] * n + [(None, None)]

# === Step 4: Solve LP ===
res = linprog(c, A_ub=lhs_ineq, b_ub=rhs_ineq,
              A_eq=lhs_eq, b_eq=rhs_eq,
              bounds=bounds, method="highs")

# === Step 5: Display results ===
p_star = res.x[:n]
v_star = res.x[-1]

print("Equilibrium mixed strategy (p*):")
for name, p in zip(characters, p_star):
    cap = f" (max {max_usage[characters.index(name)]:.3f})" if max_usage is not None else ""
    print(f"  {name:10s}: {p:.3f}{cap}")
print(f"\nExpected game value (v*): {v_star:.3f}")

if res.status != 0:
    print("\n⚠️ Optimization warning:", res.message)