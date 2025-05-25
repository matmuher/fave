import argparse

parser = argparse.ArgumentParser()
parser.add_argument("--regm", help="Regfile init content")
parser.add_argument("--insm", help="InstrMem init content")
parser.add_argument("--datm", help="DataMem init content")
args = parser.parse_args()

RegsMemSize = 32
InstrMemSize = 256
DataMemSize = 256

with open(args.regm, "w") as f:
    for i in range(RegsMemSize):
        f.write(f"{i:08X}\n")

with open(args.insm, "w") as f:
    for i in range(InstrMemSize):
        if i == 0:
            f.write(f"FFC4A303\n")
        else:
            f.write(f"{i:08X}\n")

with open(args.datm, "w") as f:
    for i in range(DataMemSize):
        f.write(f"{i:08X}\n")
