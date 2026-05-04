import re, os, csv, sys
import json
from collections import defaultdict
from pathlib import Path
import shutil

sys.path.append("../../")
from GA_classes import Individual, CMD_Block

from datetime import datetime

timestamp = datetime.now().strftime("%Y%m%d_%H%M")

CSV_PATH = f"ML_data/win_rates.csv"
timestamp_path = f"ML_data/win_rates{timestamp}.csv"
IKEMEN_PATH = r"C:\Users\greni\Desktop\works\Year4\Final Year Project\prototyping\Ikemen_GO-v0.99.0-windows\Ikemen_GO.exe"
IKEMEN_DIR = r"C:\Users\greni\Desktop\works\Year4\Final Year Project\prototyping\Ikemen_GO-v0.99.0-windows"


K=32

def expected_score(rating_a: float, rating_b: float) -> float:
    """Expected score for player A against player B."""
    return 1 / (1 + 10 ** ((rating_b - rating_a) / 400))

def update_elo(winner: Individual, loser: Individual) -> None:
    """
    Update Elo ratings in-place after a single match.
    Call once per match with the winner and loser.
    """
    expected_w = expected_score(winner.elo_rating, loser.elo_rating)
    expected_l = expected_score(loser.elo_rating, winner.elo_rating)
    winner.elo_rating += K * (1 - expected_w)
    loser.elo_rating  += K * (0 - expected_l)

def update_elo_draw(ind_a: Individual, ind_b: Individual) -> None:
    """Update Elo ratings in-place for a draw."""
    expected_a = expected_score(ind_a.elo_rating, ind_b.elo_rating)
    expected_b = expected_score(ind_b.elo_rating, ind_a.elo_rating)
    ind_a.elo_rating += K * (0.5 - expected_a)
    ind_b.elo_rating += K * (0.5 - expected_b)
    
def parse_match_log(log_path):
    with open(log_path, "r") as f:
        content = f.read()

    def get_value(key, text):
        match = re.search(rf'\[{key}\] => (\S+)', text)
        return match.group(1) if match else None

    win_team = get_value("winTeam", content)
    
    # Get character names (first occurrence = p1, second = p2)
    names = re.findall(r'\[name\] => "(\w+)"', content)
    p1_name = names[0] if len(names) > 0 else "P1"
    p2_name = names[1] if len(names) > 1 else "P2"

    win_team = int(win_team)
    # winner = p1_name if win_team == 0 else p2_name if win_team == 1 else "Draw"

    # print(f"done processing{log_path}")
    return {
        "p1" : p1_name,
        "p2" : p2_name,
        "win_team": win_team
    }

def get_from_csv():
    if not os.path.exists(CSV_PATH):
        return {}
    with open(CSV_PATH, "r") as f:
        reader = csv.DictReader(f)
        matrix = defaultdict(lambda: defaultdict(int))
        chars = []
        chars = reader.fieldnames[1:]  # Skip "Character" column
        
        for row in reader:
            char = row["Character"]
            for opponent in chars:
                matrix[char][opponent] = float(row[opponent])
                
        # print(json.dumps(matrix, indent=4))
    return matrix

def append_to_matrix(log_list, matrix = {}):
    if len(matrix) <=0:
        for entry in log_list:
            p1_name = entry["p1"]
            p2_name = entry["p2"]
            matrix.setdefault(p1_name, {}).setdefault(p2_name,  0)
            matrix.setdefault(p2_name, {}).setdefault(p1_name,  0)
            if entry["win_team"] == 1:
                matrix[p2_name][p1_name] += 1
            if entry["win_team"] == 0:
                matrix[p1_name][p2_name] += 1
    else:
        for entry in log_list:
            p1_name = entry["p1"]
            p2_name = entry["p2"]
            if entry["win_team"] == 1:
                matrix[p2_name][p1_name] += 1
            if entry["win_team"] == 0:
                matrix[p1_name][p2_name] += 1
    
    return matrix
    
    
def reset_csv():
    """Delete win_rates.csv so the next run starts with a clean matchup matrix."""
    if os.path.exists(CSV_PATH):
        os.remove(CSV_PATH)
        print(f"[reset] Cleared {CSV_PATH}")

def put_in_csv(log_list):
    results = append_to_matrix(log_list, get_from_csv())
    
    column_headers = ["Character"] + list(results.keys())
    
    rows = []

    for character in results:           #Parse to csv friendly dict format
        row = {"Character": character}

        for opponent in results.keys():
            if opponent in results[character]:
                row[opponent] = results[character][opponent]
            else:
                row[opponent] = 0

        rows.append(row)
    
    with open(CSV_PATH, mode="w", newline="") as file:
        writer = csv.DictWriter(file, fieldnames=column_headers)
        writer.writeheader()
        writer.writerows(rows)

def process_all_logs():
    log_list = list()

    for file in os.listdir("logs"):
        if re.match(r"log_.+\.txt$", file):
            log_list.append(parse_match_log(f"logs/{file}"))
    return log_list

def process_character_logs(char: str):
    log_list = list()
    curr_dir = Path.cwd()
    os.chdir(IKEMEN_DIR)
    
    for file in os.listdir(f"logs/{char}"):
        if re.match(r"log_.+\.txt$", file):
            log_list.append(parse_match_log(f"logs/{char}/{file}"))
    os.chdir(curr_dir)
    return log_list

def clean_char_logs(char: str):
    import shutil
    curr_dir = Path.cwd()
    os.chdir(IKEMEN_DIR)
    if Path(f"logs/{char}").exists():
        shutil.rmtree(f"logs/{char}")
    Path.mkdir(f"logs/{char}")
    os.chdir(curr_dir)
    pass

def adjust_elo(log_list, population_dict):
    for entry in log_list:
        p1_name = entry["p1"]
        p2_name = entry["p2"]
        p1_individual = population_dict[p1_name]
        p2_individual = population_dict[p2_name]
        if entry["win_team"] == 0:
            update_elo(winner= p1_individual, loser= p2_individual)
        else:
            update_elo(winner=p2_individual, loser= p1_individual)
            
def clean_SHAP_logs():
    import shutil
    curr_dir = Path.cwd()
    os.chdir(IKEMEN_DIR)
    if Path(f"logs/SHAP").exists():
        shutil.rmtree(f"logs/SHAP")
    Path.mkdir(f"logs/SHAP")
    os.chdir(curr_dir)
    pass

def record_data(csv_path:str = "SHAP"):  
    put_in_csv(process_character_logs(csv_path))
    clean_SHAP_logs()
    



