`include "Defs.svh"

localparam MemSize = 256;

module DataMem
(
    input clk,
    input we,

    input Data adr, // 8 bit is enough
    input Data wd,

    output Data rd
);
    Data mem[0:MemSize-1];

    always @(posedge clk) begin
        rd <= mem[adr];

        if (we) mem[adr] <= wd;
    end

endmodule
