`include "Defs.svh"

`define CHECK_AND_MOVE_D(name, setup, test)   \
    $display("Check state: [%s]", name);    \
    setup;                                  \
    assert(test);                           \
    #2;

`define CHECK_AND_MOVE(name, test) `CHECK_AND_MOVE_D(name,,test)

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

        reset = 1; #3; reset = 0;

        // lw
        #(5*2);
        assert(faVe.regfile.mem[1] == 32'd10);

        // sw
        #(4*2);
        assert(faVe.dataMem.mem[4 >> 2] == 32'd10);

        // addd
        #(4*2);
        assert(faVe.regfile.mem[1] == 32'd20);

        // beq
        #(3*2);
        assert(faVe.pc == 32'd20);

        // adddi
        #(4*2);
        assert(faVe.regfile.mem[2] == 32'd29);

        // jal
        #(4*2);
        assert(faVe.pc == 32'd0);
        assert(faVe.regfile.mem[3] == 32'd28);

        /*
        `CHECK_AND_MOVE("init", 1);

        `CHECK_AND_MOVE("addi x6, x0, 8", faVe.regfile.mem[6] == 32'd8)

        `CHECK_AND_MOVE("addi x1, x0, 1", faVe.regfile.mem[1] == 32'd1);

        `CHECK_AND_MOVE("or x6, x6, x1", faVe.regfile.mem[6] == 32'd9);

        `CHECK_AND_MOVE("sw x6, 8(x0)", faVe.dataMem.mem[8 >> 2] == 32'd9);
    
        `CHECK_AND_MOVE("lw x7, 8(x0)", faVe.regfile.mem[7] == 32'd9);

        `CHECK_AND_MOVE("add x7, x7, x1", faVe.regfile.mem[7] == 32'd10);

        `CHECK_AND_MOVE("jal x8, 8", faVe.regfile.mem[8] == 32'd28 && faVe.pc == 32'd32);

        `CHECK_AND_MOVE("sub x7, x7, x1", faVe.regfile.mem[7] == 32'd9);

        `CHECK_AND_MOVE("beq x7, x7, -36", faVe.pc == 32'd0);

        `CHECK_AND_MOVE("loop: addi x6, x0, 8", faVe.regfile.mem[6] == 32'd8);
        */
    endtask

endmodule
