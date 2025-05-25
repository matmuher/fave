`include "Defs.svh"

module Alu
(
    input Bit clk,
    input AluCtl aluCtl,

    input RegfileOut regfileOut,

    output Data result
);
    Data src1 = regfileOut.rd1;
    Data src2 = regfileOut.rd2;

    always @(posedge clk) begin
        case(aluCtl)
            Add: result <= src1 + src2;
            Sub: result <= src1 - src2;
            Mul: result <= src1 * src2;
            Equ: result <= src1 ^ src2;
            default: result <= '0; 
        endcase
    end

endmodule
