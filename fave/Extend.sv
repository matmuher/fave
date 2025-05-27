`include "Defs.svh"

`define RangeImmI {instr[31:20]}
`define RangeImmS {instr[31:25], instr[11:7]}

module ImmExtend
(
    input Data instr,
    input ImmSrc immSrc,

    output Data imm
);
    always_comb begin
        case(immSrc)
            ImmI: imm = 32'(signed'(`RangeImmI));
            ImmS: imm = 32'(signed'(`RangeImmS));
            default: imm = 32'bx;
        endcase
    end
endmodule
