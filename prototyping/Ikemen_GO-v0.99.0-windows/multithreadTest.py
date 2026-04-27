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
    ("Ryu",   "Ryu/Ryu-AI.def"),
    ("Ken",      "Ken/Ken-AI.def"),
    ("Cammy",    "Cammy/Cammy-AI.def"),
    ("Blanka",   "Blanka/Blanka-AI.def"),
    ("Fei-Long", "Fei-Long/Fei-Long-AI.def"),
    # ("M.Bison",  "M.Bison/M.Bison-AI.def"),
    ("Sagat",    "Sagat/Sagat-AI.def"),
    ("Akuma","Akuma/Akuma-AI.def")
]

AI_LEVEL = "2"
MAX_CONCURRENT =   10   # Tune this to your CPU/RAM capacity



# Generate all unique matchups (order doesn't matter, no mirror matches)
matches = [
    {
        "p1_name": p1[0], "p1_char": p1[1],
        "p2_name": p2[0], "p2_char": p2[1],
        "log": f"logs/SHAP/log_{p1[0]}_vs_{p2[0]}.txt"
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
CSV_PATH = f"ML_data/win_rates.csv"
timestamp_path = f"ML_data/win_rates{timestamp}.csv"

if __name__ == "__main__":
    arguments = sys.argv
    script_name = sys.argv[0]  # Name of the script

    # Checking if an argument is provided before accessing it
    if len(sys.argv) > 1:
        first_argument = sys.argv[1]  # First argument
    else:
        first_argument = 1  # No argument provided

    match_log_parser.reset_csv()   # always start with a clean matrix

    start_time = time.perf_counter()
    for i in range(int(first_argument)):
        print(f"round-robin:{i+1}/{first_argument}")
        run_simulation()
        match_log_parser.record_data()
    shutil.copyfile(CSV_PATH, timestamp_path)
    print(f"All matches complete, took {time.perf_counter()-start_time:.4f}")