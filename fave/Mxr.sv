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

module Mxr2Bit(
    input [1:0] signal,

    input Data src1,
    input Data src2,
    input Data src3,
    input Data src4,

    output Data result
);

    always_comb begin
        case(signal)
            2'b00: result = src1;
            2'b01: result = src2;
            2'b10: result = src3;
            2'b11: result = src4;
        endcase
    end

endmodule;