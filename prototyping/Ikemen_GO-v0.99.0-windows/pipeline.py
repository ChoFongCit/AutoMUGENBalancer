import shutil
import match_log_parser
from Data_collection import run_simulation, CSV_PATH, timestamp_path
import sys
import time
from datetime import datetime


def run_matches(rounds: int = 1) -> None:
    print("=" * 60)
    print("  STEP 1 — MATCHUP SIMULATION")
    print("=" * 60)

    match_log_parser.reset_csv()

    start = time.perf_counter()
    for i in range(rounds):
        print(f"\nRound-robin {i + 1}/{rounds}")
        run_simulation()
        match_log_parser.record_data()

    shutil.copyfile(CSV_PATH, timestamp_path)
    print(f"\nAll matches complete  ({time.perf_counter() - start:.1f}s)")
    print(f"Win rates saved to   {CSV_PATH}")


# ---------------------------------------------------------------------------
# Step 2 — Roster balancing
# ---------------------------------------------------------------------------
from roster_balancer import main as run_balancer

def run_balance() -> None:
    print("\n" + "=" * 60)
    print("  STEP 2 — ROSTER BALANCER")
    print("=" * 60 + "\n")
    run_balancer()


# ---------------------------------------------------------------------------
# Entry point
# ---------------------------------------------------------------------------
if __name__ == "__main__":
    rounds = int(sys.argv[1]) if len(sys.argv) > 1 else 1

    t0 = time.perf_counter()
    print(f"\nPipeline started  —  {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print(f"Round-robins      :  {rounds}\n")

    run_matches(rounds)
    run_balance()

    print(f"\nPipeline complete  ({time.perf_counter() - t0:.1f}s total)")