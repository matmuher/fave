`include "Defs.svh"

`define RangeImmI {instr[31:20]}
`define RangeImmS {instr[31:25], instr[11:7]}
`define RangeImmB {instr[7], instr[30:25], instr[11:8], 1'b0} 
`define RangeImmJ {instr[19:12], instr[20], instr[30:21], 1'b0}

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
            ImmB: imm = 32'(signed'(`RangeImmB));
            ImmJ: imm = 32'(signed'(`RangeImmJ));
            default: imm = 32'bx;
        endcase
    end
endmodule
