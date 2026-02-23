import subprocess

IKEMEN_PATH = r"C:\Users\greni\Desktop\works\Year4\Final Year Project\prototyping\Ikemen_GO-v0.99.0-windows\Ikemen_GO.exe"
p1_char = "Ryu/Ryu-AI.def"
p2_char = "RyuDefault/Ryu.def"
ai1 = "8"
ai2 = "8"
cmd = [
        IKEMEN_PATH,
        "-p1", p1_char, "-p1.ai", str(ai1),
        "-p2", p2_char, "-p2.ai", str(ai2), "-log", "mylog.txt"
    ]

print("Running:", " ".join(cmd))
proc = subprocess.Popen(cmd)


# Wait for match to finish
proc.wait()