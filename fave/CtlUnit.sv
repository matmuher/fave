module CtlUnit(
    input Data instr,

    output CtlSignals ctl,
    output AluCtl aluCtl
);
    always_comb begin
        case(instr[6:0])
            // lw
            7'b0000011: begin
                ctl = {DataWeNoo, RegWeYes, ImmI, AluSrcImm, RegfileSrcDataMem, IsBranchNoo, IsJumpNoo};
                coarseAluOp = Add;
            end

            // addi, slti...
            7'b0010011: begin
                ctl = {DataWeNoo, RegWeYes, ImmI, AluSrcImm, RegfileSrcAlu, IsBranchNoo, IsJumpNoo};
                coarseAluOp = Mor;
            end

            // sw
            7'b0100011: begin
                ctl = {DataWeYes, RegWeNoo, ImmS, AluSrcImm, RegfileSrcDataMem, IsBranchNoo, IsJumpNoo};
                coarseAluOp = Add;
            end

            // add, slt...
            7'b0110011: begin
                 ctl = {DataWeNoo, RegWeYes, ImmX, AluSrcRd2, RegfileSrcAlu, IsBranchNoo, IsJumpNoo};
                 coarseAluOp = Mor;
            end

            // beq
            7'b1100011: begin
                ctl = {DataWeNoo, RegWeNoo, ImmB, AluSrcRd2, RegfileSrcXXX, IsBranchYes, IsJumpNoo};
                coarseAluOp = Sub;
            end

            // jal
            7'b1101111: begin
                ctl = {DataWeNoo, RegWeYes, ImmJ, AluSrcXXX, RegfileSrcPcPlus4, IsBranchNoo, IsJumpYes};
                coarseAluOp = Mor;
            end

            default: begin
                ctl = {DataWeXXX, RegWeXXX, ImmX, AluSrcXXX, RegfileSrcXXX, IsBranchXXX, IsJumpXXX};
                coarseAluOp = Xxx;
            end
        endcase
    end

    AluCtl coarseAluOp;
    AluDecoder aluDecoder(
        .opb5(instr[5:5]),
        .funct3(instr[14:12]),
        .funct7b5(instr[30:30]),
        .coarseAluOp(coarseAluOp),
        
        .aluCtl(aluCtl));

endmodule;
