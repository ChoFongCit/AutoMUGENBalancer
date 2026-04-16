import subprocess
import concurrent.futures
from itertools import combinations
# import time
# import sys
import os
# import match_log_parser
from pathlib import Path
from GA_classes import Individual

MAX_CONCURRENT =   10   # Tune this to your CPU/RAM capacity
AI_LEVEL = "8"

IKEMEN_PATH = r"C:\Users\greni\Desktop\works\Year4\Final Year Project\prototyping\Ikemen_GO-v0.99.0-windows\Ikemen_GO.exe"
IKEMEN_DIR = r"C:\Users\greni\Desktop\works\Year4\Final Year Project\prototyping\Ikemen_GO-v0.99.0-windows"

def generate_matches_GA(population : list[Individual]):
    ROSTER = [(population[x].name, str(population[x].def_path)) for x in population]
    char_name= Path.cwd().name
    log_dir = f"logs/{char_name}"
    past_dir = Path.cwd()
    os.chdir(IKEMEN_DIR)
    Path(log_dir).mkdir(parents=True, exist_ok=True)
    print(ROSTER)
    matches = [
        {
            "p1_name": p1[0], "p1_char": p1[1],
            "p2_name": p2[0], "p2_char": p2[1],
            "log": f"logs/{char_name}/log_{p1[0]}_vs_{p2[0]}.txt"
        }
        for p1, p2 in combinations(ROSTER, 2)
    ]
    os.chdir(past_dir)
    return matches
    
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
        time.sleep(random.uniform(0.5, 2.0))
        
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
    return match


def round_robin(population : list[Individual]):
    matches = generate_matches_GA(population)
    char_Path = Path.cwd()
    os.chdir(IKEMEN_DIR)
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
    os.chdir(char_Path)
                
        