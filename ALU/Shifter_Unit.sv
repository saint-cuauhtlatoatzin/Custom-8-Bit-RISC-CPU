module shifter_8bit (
    input logic [7:0] A,
    input logic [1:0] OP,
    output logic [7:0] Result
);

always_comb begin
    case(OP)

        // Logical shift left
        2'b00:
            Result = A << 1;

        // Logical shift right
        2'b01:
            Result = A >> 1;

        // Rotate left
        2'b10:
            Result = {A[6:0], A[7]};

        // Rotate right
        2'b11:
            Result = {A[0], A[7:1]};

        default:
            Result = 8'b0;

    endcase
end
endmodule


