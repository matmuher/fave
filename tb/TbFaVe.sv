`include "Defs.svh"

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

        `TEST("check x6",

            #1;,

            #2; $display("x6 = %x", faVe.regfile.mem[6]);
        );

    endtask

endmodule
