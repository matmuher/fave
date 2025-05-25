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
        `TEST(read a1,
            instr = 32'hFFC4A303;
            #5;
            assert(regfile.a1 == 5'h9);
            assert(regfile.a3 == 5'h6);
            assert(regfileOut.rd1 == 32'h9); // init mem: x1 = 1, x2 = 2 ...
        );

        `TEST(write a3,
            regfileWe = 1'b1;
            regfileWd3 = 32'hFA5E;
            #5;
            assert(regfile.mem[5'h6] == 32'hFA5E);
        );
    endtask

endmodule
