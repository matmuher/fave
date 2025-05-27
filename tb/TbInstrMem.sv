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
        /*
        `TEST("read instr",
            
            pc = InstrLoadAdr + 4;,

            // init instr mem: mem[0] = FFC4A303, mem[1] = 0064A423, mem[2] = 2 ...
            assert(instr == 32'h00800313);
        );

        `TEST("read next instr",
            
            pc = InstrLoadAdr + 8;,

            assert(instr == 32'h00100093);
        );
        */
    endtask

endmodule
