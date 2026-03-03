import re, os, csv
import json
from collections import defaultdict

CSV_PATH = "ML_data/win_rates.csv"

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
            
def record_data():         
    put_in_csv(process_all_logs())
