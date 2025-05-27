`include "Defs.svh"

`define CHECK_AND_MOVE(name, test)          \
    $display("Check state: [%s]", name);    \
    assert(test);                           \
    #2;                                     \

module TbFaVe(
    input clk
);
    Bit reset;
    FaVe faVe(
        .reset(reset),
        .clk(clk)
    );

//---------------------------------------------------------

    task run();
        $display(">>> FaVe");

        reset = 1; #2; reset = 0; 
        
        // initial
        `CHECK_AND_MOVE("init", 1);
        // after lw
        `CHECK_AND_MOVE("lw", faVe.regfile.mem[6] == 32'hA)
        // after sw
        `CHECK_AND_MOVE("sw", faVe.dataMem.mem['h200C] == 32'hA);
        // after or
        `CHECK_AND_MOVE("or", faVe.regfile.mem[4] == 32'hE);

    endtask

endmodule
