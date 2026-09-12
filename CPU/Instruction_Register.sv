module instruction_register(
    input logic clk,
    input logic RST,
    input logic LOAD,
    input logic [15:0] INSTRUCTION_IN,

    output logic [15:0] INSTRUCTION_OUT
);

always_ff @(posedge clk) begin

    if(RST)
        INSTRUCTION_OUT <= 16'b0;

    else if(LOAD)
        INSTRUCTION_OUT <= INSTRUCTION_IN;

end
endmodule
