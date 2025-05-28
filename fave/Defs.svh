`ifndef DEFS_SVH
`define DEFS_SVH

typedef logic [4:0]  RegIdx;
typedef logic [31:0] Data;
typedef logic [0:0] Bit;

typedef struct packed {
    Data rd1;
    Data rd2;
} RegfileOut;

typedef enum logic [1:0] {
    RegfileSrcAlu = 2'b00,
    RegfileSrcDataMem = 2'b01,
    RegfileSrcPcPlus4 = 2'b10,
    RegfileSrcZero = 2'b11,
    RegfileSrcXXX = 2'bxx
} RegfileSrc;

typedef enum logic [0:0] {
    AluSrcRd2 = 1'b0,
    AluSrcImm = 1'b1,
    AluSrcXXX = 1'bx
} AluSrc;

typedef enum logic [0:0] {
    PcSrcPlus4 = 1'b0,
    PcSrcTarget = 1'b1,
    PcSrcXXX = 1'bx
} PcSrc;

typedef enum logic [1:0] {
    ImmI = 2'b00,
    ImmS = 2'b01,
    ImmB = 2'b10,
    ImmJ = 2'b11,
    ImmX = 2'bxx
} ImmSrc;

typedef enum logic [2:0] {
    Add = 3'b000,
    Sub = 3'b001,
    And = 3'b010,
    Orr = 3'b011,
    Slt = 3'b101,
    Mor = 3'b111,
    Xxx = 3'bxxx 
} AluCtl;

typedef enum logic [0:0] {
    IsBranchNoo = 1'b0,
    IsBranchYes = 1'b1,
    IsBranchXXX = 1'bx
} IsBranch;

typedef enum logic [0:0] {
    IsJumpNoo = 1'b0,
    IsJumpYes = 1'b1,
    IsJumpXXX = 1'bx
} IsJump;

typedef enum logic [0:0] {
    RegWeNoo = 1'b0,
    RegWeYes = 1'b1,
    RegWeXXX = 1'bx
} RegWe;

typedef enum logic [0:0] {
    DataWeNoo = 1'b0,
    DataWeYes = 1'b1,
    DataWeXXX = 1'bx
} DataWe;

typedef enum logic [0:0] {
    FetchInstrNoo = 1'b0,
    FetchInstrYes = 1'b1,
    FetchInstrXXX = 1'bx
} FetchInstr;

typedef enum logic [0:0] {
    PcEnNoo = 1'b0,
    PcEnYes = 1'b1,
    PcEnXXX = 1'bx
} PcEn;

typedef struct packed {
    PcEn pcEn;
    FetchInstr fetchInstr;
    DataWe dataMemWe;
    RegWe regfileWe;
    ImmSrc immSrc;
    AluSrc aluSrc;
    RegfileSrc regfileSrc;
    IsBranch isBranch;
    IsJump isJump;
} CtlSignals;

`define TEST(name, setup, test)                     \
        setup;                                      \
        reset = 1; #2; reset = 0; #2;               \
        $display("test: [%s]", name);               \
        test;                                       \

localparam InstrLoadAdr = 'd0;

typedef enum logic [3:0] {
    XStage,
    Fetch,
    Decode,
    ComputeAdr,
    ReadMem,
    WriteMemToReg,
    WriteMem,
    ExecuteR,
    WriteAluToReg,
    Beq,
    ExecuteI,
    Jal
} State;

`endif // DEFS_SVH
