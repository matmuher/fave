`include "Defs.svh"

module FaVe
(
    input reset,
    input clk
);

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
        .reset(reset),
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

endmodule

