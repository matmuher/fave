`include "Defs.svh"

module FaVe
(
);
    Bit clk;
    Data pc;
    InstrMem instrMem(
        .clk(clk),
        .pc(pc),
        
        .instr(instrMemOut));
    Data instrMemOut;

    Data imm;
    ImmExtend immExtend(
        .clk(clk),

        .instr(instrMemOut),

        .imm(imm)
    );

    Data writeData;
    Bit regfileWe = 1'b0;
    Regfile regfile(
        .clk(clk),
        .we(regfileWe),

        .instr(instrMemOut),
        .wd3(writeData),

        .out(regfileOut));
    RegfileOut regfileOut;

    AluCtl aluCtl = Add;
    Alu alu(
        .clk(clk),
        .aluCtl(aluCtl),

        .regfileOut(regfileOut),

        .result(aluResult)
    );
    Data aluResult;

    Bit dataMemWe = 1'b0;
    Data adr;
    Data dataMemWd;
    DataMem dataMem(
        .clk(clk),
        .we(dataMemWe),

        .adr(adr),
        .wd(dataMemWd),

        .rd(dataMemOut)
    );
    Data dataMemOut;

//---------------------------------------------------------

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $dumpfile(`WAVEFRONT_PATH);
        $dumpvars();
        $display("Dump to %0", `WAVEFRONT_PATH);
        $display("Easy come");
        
        #100;        

        $display("- easy go");
        $finish;
    end
endmodule

