module Mxr1Bit(
    input signal,

    input Data src1,
    input Data src2,

    output Data result
);

    always_comb begin
        case(signal)
            1'b0: result = src1;
            1'b1: result = src2;
        endcase
    end

endmodule;
