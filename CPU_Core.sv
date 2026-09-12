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
