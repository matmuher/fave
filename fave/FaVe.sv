`include "Defs.svh"

module FaVe
(
    input reset,
    input clk
);
    Data pc = 0;

    Sum2 pcPlus4Sum2(
        .src1(pc),
        .src2(4),
        
        .result(pcPlus4));
    Data pcPlus4;

    Sum2 pcTargetSum(
        .src1(imm),
        .src2(pc),
        
        .result(pcTarget));
    Data pcTarget;

    Mxr1Bit pcSrcMxr(
        .signal(pcSrc),

        .src1(pcPlus4),
        .src2(pcTarget),
        
        .result(pcNext));
    Data pcNext;

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
 
    ImmExtend immExtend(
        .immSrc(immSrc),
        .instr(instr),

        .imm(imm));
    Data imm;

    Mxr1Bit regfileWd3Mxr(
        .signal(regfileSrc),

        .src1(aluResult),
        .src2(dataMemOut),

        .result(regfileWd3)
    );
    Data regfileWd3;
    
    Regfile regfile(
        .reset(reset),
        .clk(clk),
        .we(regfileWe),

        .instr(instr),
        .wd3(regfileWd3),

        .out(regfileOut));
    RegfileOut regfileOut;

    Mxr1Bit aluSrc2Mxr(
        .signal(aluSrc),

        .src1(regfileOut.rd2),
        .src2(imm),
        
        .result(aluSrc2));
    Data aluSrc2;

    Alu alu(
        .aluCtl(aluCtl),

        .src1(regfileOut.rd1),
        .src2(aluSrc2),

        .result(aluResult),
        .isZero(isZero)
    );
    Data aluResult;
    Bit isZero;

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
        .isZero(isZero),
        
        .dataMemWe(dataMemWe),
        .regfileWe(regfileWe),
        .regfileSrc(regfileSrc),
        .aluSrc(aluSrc),
        .immSrc(immSrc),
        .aluCtl(aluCtl),
        .pcSrc(pcSrc));
    Bit dataMemWe;
    Bit regfileWe;
    Bit regfileSrc;
    Bit aluSrc;
    ImmSrc immSrc;
    AluCtl aluCtl;
    Bit pcSrc;

endmodule

