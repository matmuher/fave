module CtlUnit(
    input Data instr,

    output CtlSignals ctl
);
    always_comb begin
        case(instr[6:0])
            // lw
            7'b0000011: ctl = {DataWeNoo, RegWeYes, ImmI, AluSrcImm, RegfileSrcDataMem,    Add, IsBranchNoo};
            
            // sw
            7'b0100011: ctl = {DataWeYes, RegWeNoo, ImmS, AluSrcImm, RegfileSrcDataMem,    Add, IsBranchNoo};
            
            // or
            7'b0110011: ctl = {DataWeNoo, RegWeYes, ImmX, AluSrcRd2, RegfileSrcAlu,        Orr, IsBranchNoo};

            // beq
            7'b1100011: ctl = {DataWeNoo, RegWeNoo, ImmB, AluSrcRd2, RegfileSrcXXX,        Sub, IsBranchYes};
            
            default:    ctl = {DataWeXXX, RegWeXXX, ImmX, AluSrcXXX, RegfileSrcXXX,        Xxx, IsBranchXXX};

        endcase
    end

endmodule;