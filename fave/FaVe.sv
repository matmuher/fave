`include "Defs.svh"

module FaVe
(
    input reset,
    input clk
);
    Data pc = 0;
    Data pcNext = 0;
    
    PcPlus4 pcPlus4(
        .pc(pc),
        
        .pcNext(pcNext));

    Pc pcReg(
        .clk(clk),
        .reset(reset),
        
        .pcNext(pcNext),
        
        .pc(pc));

    InstrMem instrMem(
        .reset(reset),
        .clk(clk),
        .pc(pc),
        
        .instr(instr));
    Data instr;

    Data imm;
    logic [1:0] immSrc; 
    ImmExtend immExtend(
        .immSrc(immSrc),
        .instr(instr),

        .imm(imm)
    );

    Data writeData = dataMemOut;
    Bit regfileWe = 1'b1;
    Regfile regfile(
        .reset(reset),
        .clk(clk),
        .we(regfileWe),

        .instr(instr),
        .wd3(writeData),

        .out(regfileOut));
    RegfileOut regfileOut;

    AluCtl aluCtl = Add;
    Alu alu(
        .aluCtl(aluCtl),

        .src1(regfileOut.rd1),
        .src2(imm),

        .result(aluResult)
    );
    Data aluResult;

    Bit dataMemWe;
    Data adr = aluResult;
    Data dataMemWd = regfileOut.rd2;
    DataMem dataMem(
        .reset(reset),
        .clk(clk),
        .we(dataMemWe),

        .adr(adr),
        .wd(dataMemWd),

        .rd(dataMemOut)
    );
    Data dataMemOut;

    CtlUnit ctlUnit(
        .instr(instr),
        .dataMemWe(dataMemWe),
        .immSrc(immSrc));

endmodule

