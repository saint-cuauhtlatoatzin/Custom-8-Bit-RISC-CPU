module instruction_rom (
    input logic [7:0] ADDRESS,
    output logic [15:0] INSTRUCTION
);

always_comb begin

    case(ADDRESS)

        8'd0:
            INSTRUCTION = 16'b0000_001_010_011_000;

        8'd1:
            INSTRUCTION = 16'b0001_100_101_110_000;

        8'd2:
            INSTRUCTION = 16'b0100_000_001_010_000;

        default:
            INSTRUCTION = 16'b0;

    endcase

end

endmodule
