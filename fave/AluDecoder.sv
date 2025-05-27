module AluDecoder(
    input opb5,
    input [2:0] funct3,
    input funct7b5,
    input AluCtl coarseAluOp,

    output AluCtl  aluCtl
);
    Bit IsRtypeSub;
    assign IsRtypeSub = funct7b5 & opb5; // TRUE for R–type subtract

    always_comb
        case(coarseAluOp)
            3'b000: aluCtl = Add; // add
            3'b001: aluCtl = Sub; // sub
            default:
                case(funct3) // R–type or I–type ALU
                    3'b000:
                        if (IsRtypeSub)
                            aluCtl = Sub; // sub
                        else
                            aluCtl = Add; // add, addi
                    3'b010: aluCtl = Slt; // slt, slti
                    3'b110: aluCtl = Orr; // or, ori
                    3'b111: aluCtl = And; // and, andi
                    default: aluCtl = Xxx;
                endcase
        endcase

endmodule;
