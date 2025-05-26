`include "Defs.svh"

module PcPlus4
(
    input Data pc,

    output Data pcNext
);
    Data src2;
    always_comb begin
        src2 = 1; // 1 word = 4 bytes
        pcNext = pc + src2;
    end
endmodule
