"""
plot_nash_sd.py
---------------
For every balance report in ML_data/, extract the Nash equilibrium p* values,
compute the standard deviation of p* ACROSS characters (within each report),
and plot how that spread changes across generations.

A high SD means one character dominates the pick; a low SD means picks
are more evenly distributed.
"""

import re
import numpy as np
import matplotlib.pyplot as plt
from pathlib import Path
from datetime import datetime

REPORT_DIR = Path("ML_data")
OUT_PATH   = REPORT_DIR / "nash_sd_across_chars.png"

# Regex to capture a character row in the Nash section:
#   e.g.  "  blanka            1.0000       80.3%"
ROW_RE = re.compile(
    r'^\s{2}(\S+)\s+([-\d.]+)\s+[\d.]+%\s*$',
    re.MULTILINE,
)

def parse_nash_pstar(text: str) -> dict[str, float]:
    """Return {character: p*} from the NASH EQUILIBRIUM section of a report."""
    # Isolate the Nash section
    start = text.find("NASH EQUILIBRIUM MIXED STRATEGY")
    end   = text.find("END OF REPORT", start)
    if start == -1:
        return {}
    section = text[start:end]

    result = {}
    for m in ROW_RE.finditer(section):
        char  = m.group(1)
        p_val = float(m.group(2))
        result[char] = max(0.0, p_val)   # treat tiny negatives as 0
    return result


def load_reports() -> list[tuple[datetime, dict]]:
    """Return list of (timestamp, {char: p*}) sorted chronologically."""
    reports = []
    for path in sorted(REPORT_DIR.glob("balance_report_*.txt")):
        # Parse timestamp from filename  e.g. balance_report_20260425_232254.txt
        m = re.search(r'balance_report_(\d{8}_\d{6})', path.name)
        if not m:
            continue
        ts   = datetime.strptime(m.group(1), "%Y%m%d_%H%M%S")
        text = path.read_text(encoding="utf-8", errors="replace")
        pstar = parse_nash_pstar(text)
        if pstar:
            reports.append((ts, pstar))
    return reports


def main():
    reports = load_reports()
    if not reports:
        print("No balance reports with Nash data found.")
        return

    # Build per-report SD of p* across characters
    labels = []
    sds    = []
    all_chars = sorted({c for _, d in reports for c in d})

    print(f"{'Report':<22}  {'Characters & p*':<55}  SD")
    print("-" * 90)

    for ts, pstar in reports:
        label = ts.strftime("%m-%d %H:%M")
        vals  = np.array([pstar.get(c, 0.0) for c in all_chars])
        sd    = float(np.std(vals))
        labels.append(label)
        sds.append(sd)

        char_str = "  ".join(f"{c}={pstar.get(c, 0.0):.3f}" for c in all_chars)
        print(f"{label:<22}  {char_str:<55}  {sd:.4f}")

    print(f"\nMean SD across generations : {np.mean(sds):.4f}")
    print(f"Min  SD                    : {min(sds):.4f}  ({labels[sds.index(min(sds))]})")
    print(f"Max  SD                    : {max(sds):.4f}  ({labels[sds.index(max(sds))]})")

    # Plot
    fig, ax = plt.subplots(figsize=(11, 5))
    x = range(len(labels))

    ax.bar(x, sds, color="steelblue", alpha=0.75, zorder=2)
    ax.plot(x, sds, marker="o", color="navy", linewidth=1.5, zorder=3)
    ax.axhline(np.mean(sds), color="crimson", linestyle="--",
               linewidth=1.2, label=f"Mean SD = {np.mean(sds):.3f}")

    # Annotate each bar with its SD value
    for xi, sd in zip(x, sds):
        ax.text(xi, sd + 0.004, f"{sd:.3f}", ha="center", va="bottom", fontsize=8)

    ax.set_xticks(list(x))
    ax.set_xticklabels(labels, rotation=30, ha="right", fontsize=8)
    ax.set_xlabel("Balance Report (generation)")
    ax.set_ylabel("Std Dev of Nash p* across characters")
    ax.set_title("Nash Equilibrium Pick-Rate Spread per Generation\n"
                 "(high = one character dominates; low = balanced picks)")
    ax.legend()
    ax.grid(axis="y", alpha=0.3, zorder=1)
    fig.tight_layout()
    fig.savefig(OUT_PATH, dpi=150)
    plt.close(fig)
    print(f"\nPlot saved: {OUT_PATH}")


if __name__ == "__main__":
    main()
