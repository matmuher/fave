module CtlUnit(
    input Data instr,

    output dataMemWe,
    output [1:0] immSrc
);

    always_comb begin
        case(instr)
            32'hFFC4A303: begin
                    dataMemWe = 0;
                    immSrc = 0;
                end
            32'h0064A423: begin
                    dataMemWe = 1;
                    immSrc = 1;
                end
            default: begin
                    dataMemWe = 1'bx;
                    immSrc = 2'bx;
                end
        endcase
    end

endmodule;