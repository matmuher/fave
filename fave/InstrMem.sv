`include "Defs.svh"

module InstrMem
(
    input clk,
    input Data pc,

    output Data instr
);

    assign instr = 32'hFFC4A303;

endmodule
