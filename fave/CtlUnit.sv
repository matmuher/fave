typedef enum logic [3:0] {
    Fetch,
    Decode,
    ComputeAdr,
    ReadMem,
    RegWrite
} State;

module CtlUnit(
    input clk,
    input reset,

    input Data instr,

    output CtlSignals ctl,
    output AluCtl aluCtl
);
    State state, nextState;

// [determine next state]
    always_comb begin
        case(state)
            Fetch: nextState = Decode;
            Decode: nextState = ComputeAdr;
            ComputeAdr: nextState = ReadMem;
            ReadMem: nextState = RegWrite;
            RegWrite: nextState = Fetch;
            default: nextState = Fetch;
        endcase
    end

// [change state]
    always @(posedge clk or posedge reset) begin
        if (reset) state <= Fetch;
        else state <= nextState;
    end

// [output state]
    always_comb begin
        case(state)
            Fetch: begin
                ctl = {PcEnNoo, FetchInstrYes, DataWeNoo, RegWeNoo,
                       ImmX, AluSrcXXX, RegfileSrcXXX, IsBranchXXX, IsJumpXXX};
                coarseAluOp = Xxx;
            end
            Decode: begin
                ctl = {PcEnNoo, FetchInstrNoo, DataWeNoo, RegWeNoo,
                       ImmX, AluSrcXXX, RegfileSrcXXX, IsBranchXXX, IsJumpXXX};;
                coarseAluOp = Xxx;
            end
            ComputeAdr: begin
                ctl = {PcEnNoo, FetchInstrNoo, DataWeNoo, RegWeNoo,
                       ImmI, AluSrcImm, RegfileSrcXXX, IsBranchXXX, IsJumpXXX};;
                coarseAluOp = Add;
            end
            ReadMem: begin
                ctl = {PcEnNoo, FetchInstrNoo, DataWeNoo, RegWeXXX,
                       ImmX, AluSrcXXX, RegfileSrcXXX, IsBranchXXX, IsJumpXXX};;
                coarseAluOp = Xxx;
            end
            RegWrite: begin
                ctl = {PcEnYes, FetchInstrNoo, DataWeNoo, RegWeYes,
                       ImmX, AluSrcXXX, RegfileSrcDataMem, IsBranchXXX, IsJumpXXX};;
                coarseAluOp = Xxx;
            end
            default: begin
                ctl = {PcEnXXX, FetchInstrXXX, DataWeXXX, RegWeXXX,
                       ImmX, AluSrcXXX, RegfileSrcXXX, IsBranchXXX, IsJumpXXX};;
                coarseAluOp = Xxx;
            end
        endcase
    end

    AluCtl coarseAluOp;
endmodule;

/*
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

*/