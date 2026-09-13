module register8 (
    input wire [7:0] D,
    input wire clk,
    input wire EN,
    input wire RST,

    input wire DEBUG_LOAD,
    input wire [7:0] DEBUG_VALUE,

    output wire [7:0] Q
);


dqflipflop ff0(
        .D(D[0]),
        .CE(EN),
        .RST(RST),
        .DEBUG_LOAD(DEBUG_LOAD),
        .DEBUG_VALUE(DEBUG_VALUE[0]),
        .clk(clk),
        .Q(Q[0])
);


dqflipflop ff1(
        .D(D[1]),
        .CE(EN),
        .RST(RST),
        .DEBUG_LOAD(DEBUG_LOAD),
        .DEBUG_VALUE(DEBUG_VALUE[1]),
        .clk(clk),
        .Q(Q[1])
);


dqflipflop ff2(
        .D(D[2]),
        .CE(EN),
        .RST(RST),
        .DEBUG_LOAD(DEBUG_LOAD),
        .DEBUG_VALUE(DEBUG_VALUE[2]),
        .clk(clk),
        .Q(Q[2])
);


dqflipflop ff3(
        .D(D[3]),
        .CE(EN),
        .RST(RST),
        .DEBUG_LOAD(DEBUG_LOAD),
        .DEBUG_VALUE(DEBUG_VALUE[3]),
        .clk(clk),
        .Q(Q[3])
);


dqflipflop ff4(
        .D(D[4]),
        .CE(EN),
        .RST(RST),
        .DEBUG_LOAD(DEBUG_LOAD),
        .DEBUG_VALUE(DEBUG_VALUE[4]),
        .clk(clk),
        .Q(Q[4])
);


dqflipflop ff5(
        .D(D[5]),
        .CE(EN),
        .RST(RST),
        .DEBUG_LOAD(DEBUG_LOAD),
        .DEBUG_VALUE(DEBUG_VALUE[5]),
        .clk(clk),
        .Q(Q[5])
);


dqflipflop ff6(
        .D(D[6]),
        .CE(EN),
        .RST(RST),
        .DEBUG_LOAD(DEBUG_LOAD),
        .DEBUG_VALUE(DEBUG_VALUE[6]),
        .clk(clk),
        .Q(Q[6])
);


dqflipflop ff7(
        .D(D[7]),
        .CE(EN),
        .RST(RST),
        .DEBUG_LOAD(DEBUG_LOAD),
        .DEBUG_VALUE(DEBUG_VALUE[7]),
        .clk(clk),
        .Q(Q[7])
);

endmodule
