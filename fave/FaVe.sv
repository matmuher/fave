`include "Defs.svh"

module FaVe
(
    input reset,
    input clk
);
    CtlUnit ctlUnit(
        .instr(instr),
        
        .ctl(ctl));
    CtlSignals ctl;

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
    Data pc;

    InstrMem instrMem(
        .reset(reset),
        .clk(clk),
        .pc(pc),
        
        .instr(instr));
    Data instr;
 
    ImmExtend immExtend(
        .immSrc(ctl.immSrc),
        .instr(instr),

        .imm(imm));
    Data imm;

    Mxr1Bit regfileWd3Mxr(
        .signal(ctl.regfileSrc),

        .src1(aluResult),
        .src2(dataMemOut),

        .result(regfileWd3)
    );
    Data regfileWd3;
    
    Regfile regfile(
        .reset(reset),
        .clk(clk),
        .we(ctl.regfileWe),

        .instr(instr),
        .wd3(regfileWd3),

        .out(regfileOut));
    RegfileOut regfileOut;

    Mxr1Bit aluSrc2Mxr(
        .signal(ctl.aluSrc),

        .src1(regfileOut.rd2),
        .src2(imm),
        
        .result(aluSrc2));
    Data aluSrc2;

    Alu alu(
        .aluCtl(ctl.aluCtl),

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
        .we(ctl.dataMemWe),

        .adr(adr),
        .wd(dataMemWd),

        .rd(dataMemOut)
    );
    Data dataMemOut;

    // if branch instr and branch is taken - choose pcTarget
    assign pcSrc = ctl.isBranch && isZero ? PcSrcTarget : PcSrcPlus4;
    Bit pcSrc;

endmodule

