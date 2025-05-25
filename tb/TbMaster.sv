`include "Defs.svh"

module TbMaster;

    Bit clk;

    TbRegfile tbRegfile(.clk(clk));

    task run_all();

        tbRegfile.run();

    endtask;

//---------------------------------------------------------

    initial begin
        $dumpfile(`WAVEFRONT_PATH);
        $dumpvars();
        $display("Dump to %0", `WAVEFRONT_PATH);
        $display("Easy come - easy go");
        $display("**Start tests**");

        run_all();
        
        $display("**Tests are OK**");
        $display("You're gonna carry this weight, space-cowboy");
        $finish;
    end

    initial begin
        clk = 0;
        forever #1 clk = ~clk;
    end

endmodule
