`include "Defs.svh"

localparam MemSize = `DATM_SIZE;

module DataMem
(
    input reset,
    input clk,
    input we,

    input Data adr, // 8 bit is enough
    input Data wd,

    output Data rd
);
    Data mem[0:MemSize-1];

    always @(posedge clk or reset) begin
        if (reset) begin
            $readmemh(`INIT_DATM, mem);
        end else begin
            rd <= mem[adr];
            if (we) mem[adr] <= wd;
        end
    end

endmodule
