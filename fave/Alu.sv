`include "Defs.svh"

module Alu
(
    input AluCtl aluCtl,

    input Data src1,
    input Data src2,

    output Data result,
    output isZero
);
    always_comb begin
        case(aluCtl)
            Add: result = src1 + src2;
            Sub: result = src1 - src2;
            Orr: result = src1 | src2;
            And: result = src1 & src2;
            Slt: result = 32'(src1 < src2);
            default: result = 'x; 
        endcase

        isZero = result == '0;
    end
endmodule
