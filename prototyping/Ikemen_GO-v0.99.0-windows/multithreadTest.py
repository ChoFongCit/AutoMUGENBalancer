import subprocess
import concurrent.futures
from itertools import combinations
import time

IKEMEN_PATH = r"C:\Users\greni\Desktop\works\Year4\Final Year Project\prototyping\Ikemen_GO-v0.99.0-windows\Ikemen_GO.exe"

# Roster - (display name, .def path)
ROSTER = [
    ("Ryu-AI",   "Ryu/Ryu-AI.def"),
    ("Ken",      "Ken/Ken.def"),
    ("Cammy",    "Cammy/Cammy.def"),
    ("Blanka",   "Blanka/Blanka.def"),
    ("Dhalsim",  "Dhalsim/Dhalsim.def"),
    ("Fei-Long", "Fei-Long/Fei-Long.def"),
    ("Guile",    "Guile/Guile.def"),
    ("M.Bison",  "M.Bison/M.Bison.def"),
    ("Sagat",    "Sagat/Sagat.def"),
    ("Zangief",  "Zangief/Zangief.def"),
]

AI_LEVEL = "8"

# Generate all unique matchups (order doesn't matter, no mirror matches)
matches = [
    {
        "p1_name": p1[0], "p1_char": p1[1],
        "p2_name": p2[0], "p2_char": p2[1],
        "log": f"log_{p1[0]}_vs_{p2[0]}.txt"
    }
    for p1, p2 in combinations(ROSTER, 2)
]

print(f"Total matches: {len(matches)}")  # 10 chars = 45 matchups

def run_match(match, index):
    cmd = [
        IKEMEN_PATH,
        "-p1",    match["p1_char"],
        "-p1.ai", AI_LEVEL,
        "-p2",    match["p2_char"],
        "-p2.ai", AI_LEVEL,
        "-log",   match["log"]
    ]
    print(f"[{index:02d}] Starting: {match['p1_name']} vs {match['p2_name']}")
    proc = subprocess.Popen(cmd)
    proc.wait()
    print(f"[{index:02d}] Finished: {match['p1_name']} vs {match['p2_name']}")
    return match

MAX_CONCURRENT =   8# Tune this to your CPU/RAM capacity
start_time = time.perf_counter()
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

print(f"All matches complete, took {time.perf_counter()-start_time:.4f}")