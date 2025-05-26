module Pc(
    input clk,
    input reset,

    input Data pcNext,

    output Data pc
);

always @(posedge clk or reset) begin
    if (reset) begin
        pc <= 0;
    end else begin
        pc <= pcNext;
    end
end

endmodule;