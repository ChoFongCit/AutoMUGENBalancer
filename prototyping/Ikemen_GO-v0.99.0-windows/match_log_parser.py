import re, os, csv
import json
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

def get_from_csv(csv_path):
    with open(file= csv_path, mode="+r") as file:
        csv.DictReader()
    
def put_in_csv(log_list):
    results = {}
    for entry in log_list:
        p1_name = entry["p1"]
        p2_name = entry["p2"]
        results.setdefault(p1_name, {}).setdefault(p2_name, {"wins": 0})
        results.setdefault(p2_name, {}).setdefault(p1_name, {"wins": 0})
        if entry["win_team"] == 1:
            results[p2_name][p1_name]["wins"]+=1
        if entry["win_team"] == 0:
            results[p1_name][p2_name]["wins"]+=1
    print(json.dumps(results, indent=4))
    column_headers = ["Character"] + list(results.keys())
    csv_name = "ML_data/win_rates.csv"
    rows = []

    for character in results:
        row = {"Character": character}

        for opponent in results.keys():
            if opponent in results[character]:
                row[opponent] = results[character][opponent]["wins"]
            else:
                row[opponent] = 0

        rows.append(row)
    print(rows)
    with open(csv_name, mode="w", newline="") as file:
        writer = csv.DictWriter(file, fieldnames=column_headers)
        writer.writeheader()
        writer.writerows(rows)

def processAllLogs():
    log_list = list()
    # print("listing log files:")
    print(len(os.listdir("logs")))
    for file in os.listdir("logs"):
        if re.match(r"log_.+\.txt$", file):
            print(file)
            log_list.append(parse_match_log(f"logs/{file}"))
            # print(log_list)
    return log_list
            
put_in_csv(processAllLogs())

# Example usage
# result = parse_match_log("log_Ryu-AI_vs_Blanka.txt")

# with open('document.csv','a') as fd:
#     fd.write(myCsvRow)
# print(result)