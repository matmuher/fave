`include "Defs.svh"

`define RangeA1 19:15
`define RangeA2 24:20
`define RangeA3 11:7
localparam RegNum = 32;

module Regfile
(
    input clk,
    input we,

    input Data instr,
    input Data wd3,

    output RegfileOut out
);
    RegIdx a1 = instr[`RangeA1];
    RegIdx a2 = instr[`RangeA2];
    RegIdx a3 = instr[`RangeA3];

    Data mem [0:RegNum-1];

    always @(posedge clk) begin
        out.rd1 <= mem[a1];
        out.rd2 <= mem[a2];

        if (we) mem[a3] <= wd3;
    end

    initial begin
        $readmemh(`INIT_REGS, mem);
        out.rd1 = 0;
    end

endmodule
