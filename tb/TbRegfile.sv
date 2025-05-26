`include "Defs.svh"

module TbRegfile(
    input clk
);
    Bit reset;
    Bit regfileWe;
    
    Data instr;
    Data regfileWd3;

    Regfile regfile(
        .reset(reset),
        .clk(clk),
        .we(regfileWe),

        .instr(instr),
        .wd3(regfileWd3),

        .out(regfileOut));

    RegfileOut regfileOut;

//---------------------------------------------------------

    task run();
        $display(">>> Regfile");

        `TEST("parse a1 && a2 && a3",
            
            instr = 32'hFFC4A303;,

            // init mem: x1 = 1, x2 = 2 ...
            assert(regfileOut.rd1 == 32'h2004);
            assert(regfileOut.rd2 == 32'(regfile.a2));
            assert(regfile.a1 == 5'b01001);
            assert(regfile.a2 == 5'b11100);
            assert(regfile.a3 == 5'b00110); 
        );

        `TEST("we: write a3",
            
            regfileWe = 1'b1;
            regfileWd3 = 32'hFA5E;,

            assert(regfile.mem[regfile.a3] == 32'hFA5E);
        );

        `TEST("!we: write a3",

            regfileWe = 1'b0;
            regfileWd3 = 32'hFA5E;,

            assert(regfile.mem[regfile.a3] == 32'(regfile.a3));
        );
    endtask

endmodule
