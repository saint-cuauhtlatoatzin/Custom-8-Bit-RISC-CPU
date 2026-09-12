`timescale 1ns/1ps

module finite_state_machine (

    input  logic       clk,
    input  logic       rst,

    input  logic [3:0] opcode,

    input  logic       carry,
    input  logic       overflow,
    input  logic       zero,

    output logic       PC_ENABLE,
    output logic       IR_LOAD,
    output logic       REG_WRITE,
    output logic [3:0] ALU_CONTROL,
    output logic       PC_LOAD,
    output logic       HALT,
    output logic       ALU_ENABLE

);

    //------------------------------------------------------
    // Opcodes
    //------------------------------------------------------

    localparam OP_ADD  = 4'b0000;
    localparam OP_SUB  = 4'b0001;
    localparam OP_AND  = 4'b0100;
    localparam OP_OR   = 4'b0101;
    localparam OP_XOR  = 4'b0110;
    localparam OP_NOT  = 4'b0111;
    localparam OP_LSL  = 4'b1000;
    localparam OP_LSR  = 4'b1001;
    localparam OP_ROL  = 4'b1010;
    localparam OP_ROR  = 4'b1011;
    localparam OP_COMP = 4'b1100;
    localparam OP_HALT = 4'b1111;

    //------------------------------------------------------
    // FSM States
    //------------------------------------------------------

    localparam FETCH     = 3'b000;
    localparam DECODE    = 3'b001;
    localparam EXECUTE   = 3'b010;
    localparam WRITEBACK = 3'b011;
    localparam HALT_CPU  = 3'b100;

    logic [2:0] state;
    logic [2:0] next_state;

    //------------------------------------------------------
    // State Register
    //------------------------------------------------------

    always_ff @(posedge clk or posedge rst) begin

        if (rst)
            state <= FETCH;
        else
            state <= next_state;

    end

    //------------------------------------------------------
    // Next State Logic
    //------------------------------------------------------

    always_comb begin

        next_state = state;

        case (state)

            FETCH:
                next_state = DECODE;

            DECODE: begin
                if (opcode == OP_HALT)
                    next_state = HALT_CPU;
                else
                    next_state = EXECUTE;
            end

            EXECUTE:
                next_state = WRITEBACK;

            WRITEBACK:
                next_state = FETCH;

            HALT_CPU:
                next_state = HALT_CPU;

            default:
                next_state = FETCH;

        endcase

    end

    //------------------------------------------------------
    // Output Logic (Moore)
    //------------------------------------------------------

    always_comb begin

        // Defaults

        PC_ENABLE   = 1'b0;
        IR_LOAD     = 1'b0;
        REG_WRITE   = 1'b0;
        ALU_ENABLE  = 1'b0;
        ALU_CONTROL = 4'b0000;
        PC_LOAD     = 1'b0;
        HALT        = 1'b0;

        case (state)

            //--------------------------------------------------
            // Fetch
            //--------------------------------------------------

            FETCH: begin
                PC_ENABLE = 1'b1;
                IR_LOAD   = 1'b1;
            end

            //--------------------------------------------------
            // Decode
            //--------------------------------------------------

            DECODE: begin
                // No control outputs needed
            end

            //--------------------------------------------------
            // Execute
            //--------------------------------------------------

            EXECUTE: begin
                ALU_ENABLE  = 1'b1;
                ALU_CONTROL = opcode;
            end

            //--------------------------------------------------
            // Write Back
            //--------------------------------------------------

            WRITEBACK: begin
                REG_WRITE = 1'b1;
            end

            //--------------------------------------------------
            // Halt
            //--------------------------------------------------

            HALT_CPU: begin
                HALT = 1'b1;
            end

        endcase

    end

endmodule
