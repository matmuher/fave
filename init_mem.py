import argparse

parser = argparse.ArgumentParser()
parser.add_argument("--regm", help="Regfile init content")
parser.add_argument("--regm_size", help="Regfile size")

parser.add_argument("--insm", help="InstrMem init content")
parser.add_argument("--insm_size", help="InstrMem size")

parser.add_argument("--datm", help="DataMem init content")
parser.add_argument("--datm_size", help="DataMem size")

args = parser.parse_args()

RegsMemSize = int(args.regm_size)
InstrMemSize = int(args.insm_size)
DataMemSize = int(args.datm_size)

init_regs = {
    5: 0x0006,
    9: 0x2004
}
with open(args.regm, "w") as f:
    for i in range(RegsMemSize):
        if i in init_regs:
            f.write(f"{init_regs[i]:08X}\n")
        else:
            f.write(f"{i:08X}\n")

instructions = [
    "FFC4A303", # lw
    "0064A423", # sw
    "0062E233", # or
]

with open(args.insm, "w") as f:
    for i in range(InstrMemSize):
        if i < len(instructions):
            f.write(f"{instructions[i]}\n")
        else:
            f.write(f"{i:08X}\n")

with open(args.datm, "w") as f:
    for i in range(DataMemSize):
        if i == 8192:
            f.write(f"{10:08X}\n")
        else:
            f.write(f"{i:08X}\n")
