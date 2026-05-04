import subprocess
import concurrent.futures
from itertools import combinations
import time
from datetime import datetime
import sys

import match_log_parser
import shutil
from GA_classes import Individual, CMD_Block


IKEMEN_PATH = r"C:\Users\greni\Desktop\works\Year4\Final Year Project\prototyping\Ikemen_GO-v0.99.0-windows\Ikemen_GO.exe"

# Roster - (display name, .def path)
ROSTER = [
    # ("RyuGen1",   "Ryu/RyuGen1.def"),
    # ("RyuGen2",   "Ryu/RyuGen2.def"),
    ("RyuGen3",   "Ryu/RyuGen3.def"),
    ("RyuDefault", "Ryu/Ryu.def")
]

AI_LEVEL = "2"
MAX_CONCURRENT =   10   # Tune this to your CPU/RAM capacity
population: dict[str, Individual] = {
    entry[0]: Individual(
        def_path   = entry[1],
        cmd_path   = "",
        elo_rating = 1000,
        name       = entry[0],
    )
    for entry in ROSTER
}



# Generate all unique matchups (order doesn't matter, no mirror matches)
matches = [
    {
        "p1_name": p1[0], "p1_char": p1[1],
        "p2_name": p2[0], "p2_char": p2[1],
        "log": f"logs/GATest/log_{p1[0]}_vs_{p2[0]}.txt"
    }
    for p1, p2 in combinations(ROSTER, 2)
]

print(f"Total matches: {len(matches)}")  # 10 chars = 45 matchups

MAX_RETRIES = 3
def run_match(match, index):
    cmd = [
        IKEMEN_PATH,
        "-p1",    match["p1_char"],
        "-p1.ai", AI_LEVEL,
        "-p2",    match["p2_char"],
        "-p2.ai", AI_LEVEL,
        "-log",   match["log"],
        "-speed", "400",
        "-nosound"
    ]
    # print(f"[{index:02d}] Starting: {match['p1_name']} vs {match['p2_name']}")
    for attempt in range(1, MAX_RETRIES + 1):
        import time, random

        # inside the loop, before retrying:
        time.sleep(random.uniform(0.5, 4.0))
        
        proc = subprocess.Popen(cmd, stderr=subprocess.PIPE)
        _, stderr_output = proc.communicate()

        if proc.returncode == 0:
            return match

        stderr_text = stderr_output.decode("utf-8", errors="replace")
        print(f"[{index:02d}] Attempt {attempt}/{MAX_RETRIES} failed "
              f"({match['p1_name']} vs {match['p2_name']}): {stderr_text.strip()}")

        if attempt == MAX_RETRIES:
            raise RuntimeError(
                f"Match failed after {MAX_RETRIES} attempts: "
                f"{match['p1_name']} vs {match['p2_name']}\n{stderr_text}"
            )
    # print(f"[{index:02d}] Finished: {match['p1_name']} vs {match['p2_name']}")


def run_simulation():
    
    with concurrent.futures.ThreadPoolExecutor(max_workers=MAX_CONCURRENT) as executor:
        futures = {
            executor.submit(run_match, match, i + 1): match
            for i, match in enumerate(matches)
        }
        for future in concurrent.futures.as_completed(futures):
            match = futures[future]
            try:
                future.result()
            except Exception as e:
                print(f"Error in {match['p1_name']} vs {match['p2_name']}: {e}")
                
    # for match_info in matches:
    #     match_log_parser.parse_match_log(match_info["log"]) 

timestamp = datetime.now().strftime("%Y%m%d_%H%M")
CSV_PATH = f"ML_data/GATest/win_rates.csv"
timestamp_path = f"ML_data/GATest/win_rates{timestamp}.csv"

def update_elo_from_round():
    """
    Parse every match log from the last round and update ELO ratings.
    Uses the match dict (not log content) to identify p1/p2 so unique
    names work even when in-game character names are identical.
    """
    for match in matches:
        try:
            result = match_log_parser.parse_match_log(match["log"])
        except Exception as e:
            print(f"  [ELO] Could not read {match['log']}: {e}")
            continue

        p1 = population[match["p1_name"]]
        p2 = population[match["p2_name"]]

        if result["win_team"] == 0:
            match_log_parser.update_elo(winner=p1, loser=p2)
        elif result["win_team"] == 1:
            match_log_parser.update_elo(winner=p2, loser=p1)
        else:
            match_log_parser.update_elo_draw(p1, p2)

def print_elo():
    print("  ELO standings:")
    for ind in sorted(population.values(), key=lambda x: x.elo_rating, reverse=True):
        print(f"    {ind.name:<20}  {ind.elo_rating:.1f}")
        
def plot_elo(elo_history: dict, rounds: int, out_path: str = "ML_data/elo_progression.png"):
    import matplotlib.pyplot as plt

    fig, ax = plt.subplots(figsize=(10, 6))
    x = list(range(1, rounds + 1))

    for name, ratings in elo_history.items():
        ax.plot(x, ratings, marker="o", label=name)
        ax.annotate(f"{ratings[-1]:.0f}",
                    xy=(x[-1], ratings[-1]),
                    xytext=(4, 0), textcoords="offset points",
                    va="center", fontsize=8)

    ax.set_xlabel("Round")
    ax.set_ylabel("ELO Rating")
    ax.set_title("ELO Rating Progression per Round")
    ax.set_xticks(x)
    ax.axhline(1000, color="grey", linestyle="--", linewidth=0.8, label="Start (1000)")
    ax.legend()
    ax.grid(True, alpha=0.3)
    fig.tight_layout()
    fig.savefig(out_path, dpi=150)
    plt.close(fig)
    print(f"  ELO plot saved: {out_path}")

if __name__ == "__main__":
    rounds = int(sys.argv[1]) if len(sys.argv) > 1 else 1

    # match_log_parser.reset_csv()

    # ELO history: name → list of ratings after each round
    elo_history = {name: [] for name in population}

    start_time = time.perf_counter()

    for i in range(rounds):
        print(f"\nRound-robin: {i + 1}/{rounds}")
        run_simulation()
        match_log_parser.record_data()

        update_elo_from_round()
        for name, ind in population.items():
            elo_history[name].append(ind.elo_rating)
        print_elo()

    # shutil.copyfile(CSV_PATH, timestamp_path)
    elapsed = time.perf_counter() - start_time
    print(f"\nAll matches complete, took {elapsed:.2f}s")

    # Final ELO summary
    print("\nFinal ELO:")
    for ind in sorted(population.values(), key=lambda x: x.elo_rating, reverse=True):
        change = ind.elo_rating - 1000
        print(f"  {ind.name:<20}  {ind.elo_rating:.1f}  ({change:+.1f})")

    if rounds > 0:
        plot_elo(elo_history, rounds)