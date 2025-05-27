module Pc(
    input clk,
    input reset,

    input Data pcNext,

    output Data pc
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        pc <= InstrLoadAdr;
    end else begin
        pc <= pcNext;
    end
end

endmodule;