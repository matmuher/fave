`include "Defs.svh"

module TbAlu(
    input clk
);
    Bit reset; // not used
    AluCtl aluCtl = Add;
    Data src1;
    Data src2;
    Alu alu(
        .aluCtl(aluCtl),

        .src1(src1),
        .src2(src2),

        .result(result),
        .isZero(isZero)
    );
    Data result;
    Bit isZero;

//---------------------------------------------------------

    task run();
        $display(">>> Alu");

        `TEST("add",

            aluCtl = Add;            
            src1 = 32'h2004;
            src2 = 32'hFFFFFFFC;,

            assert(result == 32'h2000);
        );

        `TEST("orr",
            
            aluCtl = Orr;            
            src1 = 32'b0101;
            src2 = 32'b1010;,

            assert(result == 32'b1111);
        );

        `TEST("and",

            aluCtl = And;            
            src1 = 32'b0101;
            src2 = 32'b1110;,

            assert(result == 32'b0100);
        );

        `TEST("slt: true",

            aluCtl = Slt;            
            src1 = 32'd5;
            src2 = 32'd6;,

            assert(result == 32'b1);
        );

        `TEST("slt: false",

            aluCtl = Slt;            
            src1 = 32'd6;
            src2 = 32'd5;,

            assert(result == 32'b0);
        );

        `TEST("zero: true",

            aluCtl = Sub;            
            src1 = 32'd5;
            src2 = 32'd5;,

            assert(isZero == 1'b1);
        );

        `TEST("zero: false",

            aluCtl = Sub;            
            src1 = 32'd5;
            src2 = 32'd6;,

            assert(isZero == 1'b0);
        );
    endtask

endmodule
