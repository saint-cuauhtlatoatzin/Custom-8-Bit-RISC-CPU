`timescale 1ns/1ps

module full_adder (
    input  logic A,
    input  logic B,
    input  logic Cin,
    output logic Sum,
    output logic Cout
);

    // Sum output
    assign Sum = A ^ B ^ Cin;

    // Carry output
    assign Cout = (A & B) | (A & Cin) | (B & Cin);

endmodule

module ripple_carry_adder_8bit (
    input  logic [7:0] A,
    input  logic [7:0] B,
    input  logic Cin,
    output logic [7:0] Sum,
  	output logic Carry7,
    output logic Cout
);

    // Internal carry signals
    logic c1, c2, c3, c4, c5, c6, c7;

    // Least Significant Bit
    full_adder FA0 (
        .A(A[0]),
        .B(B[0]),
        .Cin(Cin),
        .Sum(Sum[0]),
        .Cout(c1)
    );

    // Bit 1
    full_adder FA1 (
        .A(A[1]),
        .B(B[1]),
        .Cin(c1),
        .Sum(Sum[1]),
        .Cout(c2)
    );

    // Bit 2
    full_adder FA2 (
        .A(A[2]),
        .B(B[2]),
        .Cin(c2),
        .Sum(Sum[2]),
        .Cout(c3)
    );

    // Most Significant Bit
    full_adder FA3 (
        .A(A[3]),
        .B(B[3]),
        .Cin(c3),
        .Sum(Sum[3]),
        .Cout(c4));

    full_adder FA4 (
        .A(A[4]),
        .B(B[4]),
        .Cin(c4),
        .Sum(Sum[4]),
        .Cout(c5));

    full_adder FA5 (
        .A(A[5]),
        .B(B[5]),
        .Cin(c5),
        .Sum(Sum[5]),
        .Cout(c6));

    full_adder FA6 (
        .A(A[6]),
        .B(B[6]),
        .Cin(c6),
        .Sum(Sum[6]),
        .Cout(c7));

    full_adder FA7 (
        .A(A[7]),
        .B(B[7]),
        .Cin(c7),
        .Sum(Sum[7]),
        .Cout(Cout)
    );

  assign Carry7 = c7;
endmodule

module arithmetic_unit_8bit (
    input  logic [7:0] A,
    input  logic [7:0] B,
    input  logic [1:0] OP,

    output wire [7:0] Result,
    output logic Carry,
	output logic Overflow
);

localparam ADD_OP = 2'b00;
localparam SUB_OP = 2'b01;

logic [7:0] Modified_B;
logic SUB;
logic Carry7;

assign SUB = (OP == SUB_OP);
assign Modified_B = (SUB ? ~B : B);

ripple_carry_adder_8bit adder (
    .A(A),
    .B(Modified_B),
    .Cin(SUB),
    .Sum(Result),
  	.Carry7(Carry7),
    .Cout(Carry)
);

  assign Overflow = Carry7 ^ Carry;
  
endmodule 

