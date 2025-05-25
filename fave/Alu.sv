`include "Defs.svh"

module Alu
(
    input clk,
    input AluCtl aluCtl,

    input Data src1,
    input Data src2,

    output Data result
);
    always @(posedge clk) begin
        case(aluCtl)
            Add: result <= src1 + src2;
            Sub: result <= src1 - src2;
            Mul: result <= src1 * src2;
            Neq: result <= src1 ^ src2;
            default: result <= '0; 
        endcase
    end
endmodule
