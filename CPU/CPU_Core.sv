// Code your design here
// Code your design here
`timescale 1ns/1ps

module cpu_core(

    input logic clk,
    input logic RST,

    input logic DEBUG_LOAD,
    input logic [2:0]DEBUG_REG_SEL,
    input logic [7:0] DEBUG_VALUE

);

    //--------------------------------------------------
    // Datapath Signals
    //--------------------------------------------------

    logic [7:0] PC;

    logic [15:0] instruction;
    logic [15:0] instruction_reg;

    logic [3:0] opcode;

    logic [2:0] rd;
    logic [2:0] rs1;
    logic [2:0] rs2;

    logic [7:0] QA;
    logic [7:0] QB;

    logic [7:0] Result;

    logic Carry;
    logic Overflow;
    logic Zero;

    //--------------------------------------------------
    // Control Signals
    //--------------------------------------------------

    logic PC_ENABLE;
    logic IR_LOAD;
    logic REG_WRITE;
    logic PC_LOAD;
    logic HALT;
    logic ALU_ENABLE;
  
  	logic [3:0] ALU_CONTROL;

    //--------------------------------------------------
    // Zero Flag
    //--------------------------------------------------

    assign Zero = (Result == 8'b00000000);

    //--------------------------------------------------
    // Program Counter
    //--------------------------------------------------

    pc_counter PC0(

        .clk(clk),
        .EN(PC_ENABLE),
        .RST(RST),

        .LOAD(PC_LOAD),
        .LOAD_ADDRESS(8'b00000000),

        .PC(PC)

    );

    //--------------------------------------------------
    // Instruction ROM
    //--------------------------------------------------

    instruction_rom ROM0(

        .ADDRESS(PC),

        .INSTRUCTION(instruction)

    );

    //--------------------------------------------------
    // Instruction Register
    //--------------------------------------------------

    instruction_register IR0(

        .clk(clk),
        .RST(RST),

        .LOAD(IR_LOAD),

        .INSTRUCTION_IN(instruction),

        .INSTRUCTION_OUT(instruction_reg)

    );

    //--------------------------------------------------
    // Decoder
    //--------------------------------------------------

    decoder DEC0(

        .INSTRUCTION(instruction_reg),

        .OPCODE(opcode),

        .RD(rd),
        .RS1(rs1),
        .RS2(rs2)

    );

    //--------------------------------------------------
    // Register File
    //--------------------------------------------------

registerfile RF0(
    .clk(clk),
    .EN(REG_WRITE),
    .RST(RST),

    .WRITE_SEL(rd),

    .READ_SEL_A(rs1),
    .READ_SEL_B(rs2),

    .D(Result),

    .DEBUG_LOAD(DEBUG_LOAD),
    .DEBUG_REG_SEL(DEBUG_REG_SEL),
    .DEBUG_VALUE(DEBUG_VALUE),

    .QA(QA),
    .QB(QB)
);
    // ALU
    //--------------------------------------------------

    ALU ALU0(

        .A(QA),
        .B(QB),

        .ALU_CONTROL(ALU_CONTROL),

        .Result(Result),

        .CARRY(Carry),

        .OVERFLOW(Overflow)

    );

    //--------------------------------------------------
    // Control FSM
    //--------------------------------------------------

    finite_state_machine CTRL(

        .clk(clk),
        .rst(RST),

        .opcode(opcode),

        .carry(Carry),
        .overflow(Overflow),
        .zero(Zero),

        .PC_ENABLE(PC_ENABLE),
        .IR_LOAD(IR_LOAD),
        .REG_WRITE(REG_WRITE),

        .ALU_CONTROL(ALU_CONTROL),

        .PC_LOAD(PC_LOAD),

        .HALT(HALT),

        .ALU_ENABLE(ALU_ENABLE)

    );

endmodule

module pc_counter (
    input wire clk,
    input wire EN,
    input wire RST,
    input wire LOAD,
    input wire [7:0] LOAD_ADDRESS,
    output logic [7:0] PC
);

  always_ff @(posedge clk or posedge RST) begin 
if (RST) PC <= 8'b00000000; 

else if (LOAD) PC <= LOAD_ADDRESS; 

else if (EN) PC <= PC + 1; 

else PC <= PC; 

end 
endmodule 
