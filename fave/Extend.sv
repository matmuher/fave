`include "Defs.svh"

`define RangeImmI 31:20

module ImmExtend
(
    input Data instr,

    output Data imm
);
    assign imm = 32'(signed'(instr[`RangeImmI]));
endmodule
