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


'''
Asm:
    addi x6, x0, 8
    addi x1, x0, 1
    or x6, x6, x1
    sw x6, 8(x0)
    lw x7, 8(x0)
    add x7, x7, x1
    jal x8, 8
    add x7, x7, x1
    sub x7, x7, x1
    beq x7, x7, -32
'''

instructions = [
"00800313",
"00100093",
"00136333",
"00602423",
"00802383",
"001383b3",
"0080046f",
"001383b3",
"401383b3",
"fc738ee3",
]

loadAdr = 0x0;

with open(args.insm, "w") as f:
    for i in range(InstrMemSize // 4):
        if (i < loadAdr or i >= loadAdr + len(instructions)):
            f.write(f"{i:08X}\n")
        else:
            f.write(f"{instructions[i - loadAdr]}\n")


with open(args.datm, "w") as f:
    for i in range(DataMemSize // 4):
        if i == (0x2000 // 4):
            f.write(f"{10:08X}\n")
        else:
            f.write(f"{i:08X}\n")
