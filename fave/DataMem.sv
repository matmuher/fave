`include "Defs.svh"

localparam MemSize = `DATM_SIZE;

module DataMem
(
    input reset,
    input clk,
    input we,

    input Data adr,
    input Data wd,

    output Data rd
);
    Data mem[0:MemSize-1];
    Data shiftedAdr;
    assign shiftedAdr = adr >> 2;
    assign rd = mem[shiftedAdr];

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            $readmemh(`INIT_DATM, mem);
        end else begin
            if (we) mem[shiftedAdr] = wd;
        end
    end

endmodule
