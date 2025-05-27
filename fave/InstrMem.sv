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
    Data shiftedPc;
    assign shiftedPc = pc >> 2;
    
    assign instr = mem[shiftedPc];

    always @(posedge reset) begin
        $readmemh(`INIT_INSM, mem);
    end

endmodule
