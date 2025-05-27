`ifndef DEFS_SVH
`define DEFS_SVH

typedef logic [4:0]  RegIdx;
typedef logic [31:0] Data;
typedef logic [0:0] Bit;

typedef struct packed {
    Data rd1;
    Data rd2;
} RegfileOut;

typedef enum logic [0:0] {
    RegfileSrcAlu = 1'b0,
    RegfileSrcDataMem = 1'b1,
    RegfileSrcXXX = 1'bx
} RegfileSrc;

typedef enum logic [0:0] {
    AluSrcRd2 = 1'b0,
    AluSrcImm = 1'b1,
    AluSrcXXX = 1'bx
} AluSrc;

typedef enum logic [1:0] {
    ImmI = 2'b00,
    ImmS = 2'b01,
    ImmXXX = 2'bxx
} ImmSrc;

typedef enum logic [2:0] {
    Add = 3'b000,
    Sub = 3'b001,
    Orr = 3'b010,
    And = 3'b011,
    Slt = 3'b101,
    Xxx = 3'bxxx 
} AluCtl;

`define TEST(name, setup, test)                     \
        setup;                                      \
        reset = 1; #2; reset = 0; #2;               \
        $display("test: [%s]", name);               \
        test;                                       \

`endif
