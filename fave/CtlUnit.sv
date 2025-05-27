module CtlUnit(
    input Data instr,
    input isZero,

    output dataMemWe,
    output regfileWe,
    output ImmSrc immSrc,
    output AluSrc aluSrc,
    output RegfileSrc regfileSrc,
    output AluCtl aluCtl,
    output PcSrc pcSrc
);

    always_comb begin
        case(instr)
            32'hFFC4A303: begin // lw
                    dataMemWe = 0;
                    regfileWe = 1;
                    immSrc = ImmI;
                    aluSrc = AluSrcImm;
                    regfileSrc = RegfileSrcDataMem;
                    aluCtl = Add;
                    pcSrc = PcSrcPlus4;
                end
            32'h0064A423: begin // sw
                    dataMemWe = 1;
                    regfileWe = 0;
                    immSrc = ImmS;
                    aluSrc = AluSrcImm;
                    regfileSrc = RegfileSrcDataMem;
                    aluCtl = Add;
                    pcSrc = PcSrcPlus4;
                end
            32'h0062E233: begin // or
                    dataMemWe = 0;
                    regfileWe = 1;
                    immSrc = ImmXXX;
                    aluSrc = AluSrcRd2;
                    regfileSrc = RegfileSrcAlu;
                    aluCtl = Orr;
                    pcSrc = PcSrcPlus4;
                end
            32'hFE420AE3: begin // beq
                    dataMemWe = 0;
                    regfileWe = 0;
                    immSrc = ImmB;
                    aluSrc = AluSrcRd2;
                    regfileSrc = RegfileSrcXXX;
                    aluCtl = Sub;
                    pcSrc = isZero ? PcSrcTarget : PcSrcPlus4;
                end
            default: begin
                    dataMemWe = 1'bx;
                    regfileWe = 1'bx;
                    immSrc = ImmXXX;
                    aluSrc = AluSrcXXX;
                    aluCtl = Xxx;
                end
        endcase
    end

endmodule;