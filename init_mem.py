import argparse

parser = argparse.ArgumentParser()
parser.add_argument("--regs", help="Input file")
args = parser.parse_args()

with open(args.regs, "w") as f:
    for _ in range(32):
        f.write("0000FA5E\n")

