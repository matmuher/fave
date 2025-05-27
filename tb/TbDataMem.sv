`include "Defs.svh"

module TbDataMem(
    input clk
);
    Bit reset;
    Bit dataMemWe;
    Data adr;
    Data dataMemWd;
    DataMem dataMem(
        .reset(reset),
        .clk(clk),
        .we(dataMemWe),

        .adr(adr),
        .wd(dataMemWd),

        .rd(rd)
    );
    Data rd;

//---------------------------------------------------------

    task run();
        $display(">>> DataMem");

        `TEST("read data mem",
            
            adr = 32'h2000;,

            // init mem: mem[1] = 1, mem[2] = 2 ...
            assert(rd == 32'hA);
        );

        `TEST("we: write data mem",
            
            dataMemWe = 1'b1;
            adr = 32'd16;
            dataMemWd = 32'hFA5E;,

            assert(rd == 32'hFA5E);
        );

        `TEST("!we: write data mem",

            dataMemWe = 1'b0;
            adr = 32'd12;
            dataMemWd = 32'hFA5E;,

            assert(rd == (adr >> 2));
        );
    endtask

endmodule
