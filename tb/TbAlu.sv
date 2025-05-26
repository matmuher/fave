`include "Defs.svh"

module TbAlu(
    input clk
);
    Bit reset; // not used
    AluCtl aluCtl = Add;
    Data src1;
    Data src2;
    Alu alu(
        .clk(clk),
        .aluCtl(aluCtl),

        .src1(src1),
        .src2(src2),

        .result(result)
    );
    Data result;

//---------------------------------------------------------

    task run();
        $display(">>> Alu");

        `TEST("add",

            aluCtl = Add;            
            src1 = 32'h2004;
            src2 = 32'hFFFFFFFC;,

            assert(result == 32'h2000);
        );

        `TEST("mul",
            
            aluCtl = Mul;            
            src1 = 32'd5;
            src2 = 32'd6;,

            assert(result == 32'd30);
        );

        `TEST("5 != 5",

            aluCtl = Neq;            
            src1 = 32'd5;
            src2 = 32'd5;,

            assert(result == 32'd0);
        );

        `TEST("5 != 6",

            aluCtl = Neq;            
            src1 = 32'd5;
            src2 = 32'd6;,

            assert(result != 32'd0);
        );
    endtask

endmodule
