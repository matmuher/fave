`include "Defs.svh"

module TbMaster;

    Bit clk;

    TbRegfile tbRegfile(.clk(clk));
    TbDataMem tbDataMem(.clk(clk));
    TbInstrMem tbInstrMem(.clk(clk));
    TbAlu tbAlu(.clk(clk));
    TbFaVe tbFaVe(.clk(clk));

    task run_all();

        tbRegfile.run();
        tbDataMem.run();
        tbInstrMem.run();
        tbAlu.run();
        tbFaVe.run();

    endtask;

//---------------------------------------------------------

    initial begin
        $dumpfile(`WAVEFRONT_PATH);
        $dumpvars();
        $display("Dump to %0", `WAVEFRONT_PATH);
        $display("You're gonna carry this weight, space-cowboy");
        $display("**Start tests**");

        run_all();
        
        $display("**Tests are OK**");
        $display("Easy come - easy go");
        $finish;
    end

    initial begin
        clk = 0;
        forever #1 clk = ~clk;
    end

endmodule
