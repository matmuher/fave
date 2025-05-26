`include "Defs.svh"

localparam InstrMemSize = `INSM_SIZE;

module InstrMem
(
    input reset,
    input clk,
    input Data pc,

    output Data instr
);
    Data mem[0:InstrMemSize-1];
    assign instr = mem[pc];

    always @(reset) begin
        $readmemh(`INIT_INSM, mem);
    end

endmodule
