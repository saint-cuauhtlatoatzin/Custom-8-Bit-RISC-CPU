module dqflipflop (
    input wire D,
    input wire clk,
    input wire CE,
    input wire RST,

    input wire DEBUG_LOAD,
    input wire DEBUG_VALUE,

    output reg Q
);

always @(posedge clk) begin

    if(RST)
        Q <= 1'b0;

    else if(DEBUG_LOAD)
        Q <= DEBUG_VALUE;

    else if(CE)
        Q <= D;

end

endmodule
