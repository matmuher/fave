`include "Defs.svh"

`define RangeA1 19:15
`define RangeA2 24:20
`define RangeA3 11:7
localparam RegNum = `REGM_SIZE;

module Regfile
(
    input reset,
    input clk,
    input we,

    input Data instr,
    input Data wd3,

    output RegfileOut out
);
    RegIdx a1;
    RegIdx a2;
    RegIdx a3;

    Data mem [0:RegNum-1];

    always @(posedge clk or reset) begin
        if (reset) begin
            a1 <= 0;
            a2 <= 0;
            a3 <= 0;
            $readmemh(`INIT_REGM, mem);
            out.rd1 <= 0;
            out.rd2 <= 0;
        end else begin
            a1 <= instr[`RangeA1];
            a2 <= instr[`RangeA2];
            a3 <= instr[`RangeA3];
            out.rd1 <= mem[a1];
            out.rd2 <= mem[a2];

            if (we) mem[a3] <= wd3;
        end
    end

endmodule
