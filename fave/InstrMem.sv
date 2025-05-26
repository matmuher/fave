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

    always @(posedge  clk or reset) begin
        if (reset) begin
            $readmemh(`INIT_INSM, mem);
        end else begin
            instr <= mem[pc];
        end
    end

endmodule
