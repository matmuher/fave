module CtlUnit(
    input Data instr,

    output CtlSignals ctl,
    output AluCtl aluCtl
);
    AluCtl coarseAluOp;
    AluDecoder aluDecoder(
        .opb5(instr[5:5]),
        .funct3(instr[14:12]),
        .funct7b5(instr[30:30]),
        .coarseAluOp(coarseAluOp),
        
        .aluCtl(aluCtl));

    always_comb begin
        case(instr[6:0])
            // lw
            7'b0000011: begin
                ctl = {DataWeNoo, RegWeYes, ImmI, AluSrcImm, RegfileSrcDataMem, IsBranchNoo};
                coarseAluOp = Add;
            end

            // sw
            7'b0100011: begin
                ctl = {DataWeYes, RegWeNoo, ImmS, AluSrcImm, RegfileSrcDataMem, IsBranchNoo};
                coarseAluOp = Add;
            end
            // or
            7'b0110011: begin
                 ctl = {DataWeNoo, RegWeYes, ImmX, AluSrcRd2, RegfileSrcAlu, IsBranchNoo};
                 coarseAluOp = Orr;
            end
            // beq
            7'b1100011: begin
                ctl = {DataWeNoo, RegWeNoo, ImmB, AluSrcRd2, RegfileSrcXXX, IsBranchYes};
                coarseAluOp = Sub;
            end
            default: begin
                ctl = {DataWeXXX, RegWeXXX, ImmX, AluSrcXXX, RegfileSrcXXX, IsBranchXXX};
                coarseAluOp = Xxx;
            end
        endcase


    end

endmodule;
