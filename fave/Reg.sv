module RegEn(
    input clk,
    input en,
    input reset,

    input Data resetVal,
    input Data in,

    output Data out
);
    Data internalReg;
    assign out = internalReg;

    always @(posedge clk or posedge reset) begin
        if (reset) internalReg <= resetVal;
        else if (en) internalReg <= in;
    end

endmodule;

module Reg(
    input clk,
    input reset,

    input Data resetVal,
    input Data in,

    output Data out
);

    RegEn regEn(
        .clk(clk),
        .en(1),
        .reset(reset),

        .resetVal(resetVal),
        .in(in),

        .out(out));

endmodule;