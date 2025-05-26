`ifndef DEFS_SVH
`define DEFS_SVH

typedef logic [4:0]  RegIdx;
typedef logic [31:0] Data;
typedef logic [0:0] Bit;

typedef struct packed {
    Data rd1;
    Data rd2;
} RegfileOut;

typedef enum logic [2:0] {
    Add = 3'b000,
    Sub = 3'b001,
    Mul = 3'b010,
    Neq = 3'b011  
} AluCtl;

`define TEST(name, setup, test)                     \
        setup;                                      \
        reset = 1; #2; reset = 0; #2;               \
        $display("test: [%s]", name);               \
        test;                                       \

`endif
