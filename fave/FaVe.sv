`include "Defs.svh"

module FaVe
(
    input reset,
    input clk
);
    CtlUnit ctlUnit(
        .clk(clk),
        .reset(reset),

        .instr(instrRegOut),
        
        .ctl(ctl),
        .aluCtl(aluCtl));
    CtlSignals ctl;
    AluCtl aluCtl;

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

    // if branch instr and branch is taken - choose pcTarget
    assign pcSrc = ctl.isJump || (ctl.isBranch && isZero) ? PcSrcTarget : PcSrcPlus4;
    Bit pcSrc;

    Mxr1Bit pcSrcMxr(
        .signal(pcSrc),

        .src1(pcPlus4),
        .src2(pcTarget),
        
        .result(pcNext));
    Data pcNext;

    RegEn pcReg(
        .clk(clk),
        .en(ctl.pcEn),
        .reset(reset),
        
        .resetVal(InstrLoadAdr),
        .in(pcNext),
        
        .out(pc));
    Data pc;

    InstrMem instrMem(
        .reset(reset),
        .clk(clk),
        .pc(pc),
        
        .instr(instr));
    Data instr;
 
    RegEn instrReg(
        .reset(reset),
        .clk(clk),
        .en(ctl.fetchInstr),
        
        .resetVal('hDEAD),
        .in(instr),
        
        .out(instrRegOut));
    Data instrRegOut;

    ImmExtend immExtend(
        .immSrc(ctl.immSrc),
        .instr(instrRegOut),

        .imm(imm));
    Data imm;

    Mxr2Bit regfileWd3Mxr(
        .signal(ctl.regfileSrc),

        .src1(aluRegOut),
        .src2(dataRegOut),
        .src3(pcPlus4),
        .src4(0),

        .result(regfileWd3)
    );
    Data regfileWd3;
    
    Regfile regfile(
        .reset(reset),
        .clk(clk),
        .we(ctl.regfileWe),

        .instr(instrRegOut),
        .wd3(regfileWd3),

        .out(regfileOut));
    RegfileOut regfileOut;

    Reg a1Reg(
        .clk(clk),
        .reset(reset),

        .resetVal('hA1),
        .in(regfileOut.rd1),

        .out(a1RegOut)
    );
    Data a1RegOut;

    Reg a2Reg(
        .clk(clk),
        .reset(reset),

        .resetVal('hA2),
        .in(regfileOut.rd2),

        .out(a2RegOut)
    );
    Data a2RegOut;

    Mxr1Bit aluSrc2Mxr(
        .signal(ctl.aluSrc),

        .src1(a2RegOut),
        .src2(imm),
        
        .result(aluSrc2));
    Data aluSrc2;

    Alu alu(
        .aluCtl(aluCtl),

        .src1(a1RegOut),
        .src2(aluSrc2),

        .result(aluResult),
        .isZero(isZero)
    );
    Data aluResult;
    Bit isZero;

    Reg aluReg(
        .reset(reset),
        .clk(clk),

        .resetVal('h12345),
        .in(aluResult),

        .out(aluRegOut));
    Data aluRegOut;

    DataMem dataMem(
        .reset(reset),
        .clk(clk),
        .we(ctl.dataMemWe),

        .adr(aluRegOut),
        .wd(a2RegOut),

        .rd(dataMemOut)
    );
    Data dataMemOut;

    Reg dataReg(
        .reset(reset),
        .clk(clk),

        .resetVal('hDADA),
        .in(dataMemOut),

        .out(dataRegOut));
    Data dataRegOut;

//-----------------------------

    State curState;
    assign curState = ctlUnit.state;

    integer trace_file;
    initial begin
        trace_file = $fopen("fave_trace.log", "w");
        $fwrite(trace_file, "PC\tx0-x31\n");
        $fflush(trace_file);
    end

    always @(posedge clk) begin
        if (!reset && curState == Fetch) begin
            $fwrite(trace_file, "%d", pc);
            
            for (int i = 0; i < 32; i++) begin
                $fwrite(trace_file, "%d", regfile.mem[i]);
            end
            $fwrite(trace_file, "\n");
            $fflush(trace_file);
        end
    end

    final begin
        $fclose(trace_file);
    end

endmodule

