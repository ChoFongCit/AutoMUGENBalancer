import re
import sys
#example usage: 
# python .\cmd_disector.py 'C:\Users\greni\Desktop\works\Year4\Final Year Project\prototyping\Ikemen_GO-v0.99.0-windows\chars\Zangief\SF2_zangief.cmd'

def extract_changestate_blocks(filepath):
    with open(filepath, 'r', encoding='latin-1') as f:
        content = f.read()

    # Split on [State ...] headers, keeping the delimiter
    blocks = re.split(r'(?=\[State\s)', content)

    changestate_blocks = []
    for block in blocks:
        if re.search(r'type\s*=\s*ChangeState', block, re.IGNORECASE):
            changestate_blocks.append(block.strip())

    return changestate_blocks

blocks = extract_changestate_blocks(str(sys.argv[1]))

for i, block in enumerate(blocks):
    print(f"--- Block {i+1} ---")
    print(block)
    print()