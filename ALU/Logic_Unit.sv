module logic_unit_8bit (

    input logic [7:0] A,
    input logic [7:0] B,
    input logic [1:0] OP,

    output logic [7:0] Result

);

logic [7:0] AND_Result;
logic [7:0] OR_Result;
logic [7:0] XOR_Result;
logic [7:0] NOT_Result;

assign AND_Result = A & B;
assign OR_Result  = A | B;
assign XOR_Result = A ^ B;
assign NOT_Result = ~A;

always @(*) begin

    case (OP)
        2'b00: Result = AND_Result;
        2'b01: Result = OR_Result;
        2'b10: Result = XOR_Result;
        2'b11: Result = NOT_Result;
    endcase
end

endmodule


