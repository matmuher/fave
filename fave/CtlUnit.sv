module CtlUnit(
    input Data instr,

    output dataMemWe,
    output regfileWe,
    output ImmSrc immSrc,
    output AluSrc aluSrc,
    output RegfileSrc regfileSrc,
    output AluCtl aluCtl
);

    always_comb begin
        case(instr)
            32'hFFC4A303: begin
                    dataMemWe = 0;
                    regfileWe = 1;
                    immSrc = ImmI;
                    aluSrc = AluSrcImm;
                    regfileSrc = RegfileSrcDataMem;
                    aluCtl = Add;
                end
            32'h0064A423: begin
                    dataMemWe = 1;
                    regfileWe = 0;
                    immSrc = ImmS;
                    aluSrc = AluSrcImm;
                    regfileSrc = RegfileSrcDataMem;
                    aluCtl = Add;
                end
            32'h0062E233: begin
                    dataMemWe = 0;
                    regfileWe = 1;
                    immSrc = ImmXXX;
                    aluSrc = AluSrcRd2;
                    regfileSrc = RegfileSrcAlu;
                    aluCtl = Orr;
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