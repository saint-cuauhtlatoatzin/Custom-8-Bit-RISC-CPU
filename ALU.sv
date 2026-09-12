`timescale 1ns/1ps

module ALU(
    input wire [7:0] A,
    input wire [7:0] B,
    input wire [3:0] ALU_CONTROL,

    output reg [7:0] Result,
    output logic CARRY,
    output logic OVERFLOW
);

logic [1:0] ARITH_OP;
logic [1:0] LOG_OP;
logic [1:0] SHIFT_OP;
logic [1:0] COMP_OP;

logic [7:0] ARITH_Result;
logic [7:0] LOG_Result;
logic [7:0] SHIFT_Result;
logic [7:0] COMP_Result;

logic arithmetic_carry;
logic arithmetic_overflow;

localparam OP_ADD = 4'b0000;
localparam OP_SUB = 4'b0001;
localparam OP_AND = 4'b0100;
localparam OP_OR = 4'b0101;
localparam OP_XOR = 4'b0110;
localparam OP_NOT = 4'b0111;
localparam OP_LSL = 4'b1000;
localparam OP_LSR = 4'b1001;
localparam OP_ROL = 4'b1010;
localparam OP_ROR = 4'b1011;
localparam OP_COMP = 4'b1100;

always_comb begin
        ARITH_OP = 2'b00; 
        LOG_OP = 2'b00; 
        SHIFT_OP = 2'b00; 
        COMP_OP = 2'b00;
 
        CARRY = 0; 
        OVERFLOW = 0;

        if(ALU_CONTROL == OP_ADD || ALU_CONTROL == OP_SUB) 
        begin 
CARRY = arithmetic_carry; OVERFLOW = arithmetic_overflow;  
        end 
  
    case (ALU_CONTROL)
        OP_ADD: ARITH_OP = 2'b00;
        OP_SUB: ARITH_OP = 2'b01;
        OP_AND: LOG_OP = 2'b00;
        OP_OR: LOG_OP = 2'b01;
        OP_XOR: LOG_OP = 2'b10;
        OP_NOT: LOG_OP = 2'b11;
        OP_LSL: SHIFT_OP = 2'b00;
        OP_LSR: SHIFT_OP = 2'b01;
        OP_ROL: SHIFT_OP = 2'b10;
        OP_ROR: SHIFT_OP = 2'b11;
        OP_COMP: COMP_OP = 2'b11;
        endcase
end

arithmetic_unit_8bit alu_arithmetic(
   .A(A),
    .B(B),
   .OP(ARITH_OP),
    .Result(ARITH_Result),
  .Carry(arithmetic_carry),
    .Overflow(arithmetic_overflow)
    );

logic_unit_8bit alu_logic(
   .A(A),
  .B(B),
  .OP(LOG_OP),
  .Result(LOG_Result));

shifter_8bit alu_shift(
   .A(A),
    .OP(SHIFT_OP),
    .Result(SHIFT_Result));

comparator_8bit alu_comparator(
   .A(A),
   .B(B),
   .CMP_CONTR(COMP_OP),
   .Result(COMP_Result));

always_comb begin

    Result = 8'b0;

    case (ALU_CONTROL)
        OP_ADD: Result = ARITH_Result;
        OP_SUB: Result = ARITH_Result;
        OP_AND: Result = LOG_Result;
        OP_OR: Result = LOG_Result;
        OP_XOR: Result = LOG_Result;
        OP_NOT: Result = LOG_Result;
        OP_LSL: Result = SHIFT_Result;
        OP_LSR: Result = SHIFT_Result;
        OP_ROL: Result = SHIFT_Result;
        OP_ROR: Result = SHIFT_Result;
        OP_COMP: Result = COMP_Result;
    endcase
end
endmodule

