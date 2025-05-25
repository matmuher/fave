`include "Defs.svh"

module TbInstrMem(
    input clk
);
    Bit reset;
    Data pc;
    InstrMem instrMem(
        .reset(reset),
        .clk(clk),
        .pc(pc),
        
        .instr(instr));
    Data instr;

//---------------------------------------------------------

    task run();
        $display(">>> InstrMem");

        `TEST("read instr",
            
            pc = 0;,

            // init instr mem: mem[0] = FFC4A303, mem[1] = 1, mem[2] = 2 ...
            assert(instr == 32'hFFC4A303);
        );

        `TEST("read next instr",
            
            pc = 1;,

            assert(instr == pc);
        );
    endtask

endmodule
