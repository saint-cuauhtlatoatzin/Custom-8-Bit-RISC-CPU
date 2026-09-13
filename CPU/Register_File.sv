module registerfile(
    input wire clk,
    input wire EN,
    input wire RST,
    input wire [2:0] WRITE_SEL,
    input wire [2:0] READ_SEL_A,
    input wire [2:0] READ_SEL_B,
    input wire [7:0] D,
  	input wire DEBUG_LOAD,
	input wire [2:0] DEBUG_REG_SEL,
	input wire [7:0] DEBUG_VALUE,

    output [7:0] QA,
    output [7:0] QB
);

logic [7:0] REG_EN;
wire [7:0] R0_DATA ;
wire [7:0] R1_DATA ;
wire [7:0] R2_DATA ;
wire [7:0] R3_DATA ;
wire [7:0] R4_DATA ;
wire [7:0] R5_DATA ;
wire [7:0] R6_DATA ;
wire [7:0] R7_DATA ;

always_comb begin
    REG_EN = 8'b00000000;

    case (WRITE_SEL)
        3'b000: REG_EN[0] = EN;
        3'b001: REG_EN[1] = EN;
        3'b010: REG_EN[2] = EN;
        3'b011: REG_EN[3] = EN;
        3'b100: REG_EN[4] = EN;
        3'b101: REG_EN[5] = EN;
        3'b110: REG_EN[6] = EN;
        3'b111: REG_EN[7] = EN;
    endcase
end

register8 r0 (
    .D(D),
    .EN(REG_EN[0]),
    .RST(RST),

  	.DEBUG_LOAD(DEBUG_LOAD && 		 DEBUG_REG_SEL == 3'b000),
    .DEBUG_VALUE(DEBUG_VALUE),

    .clk(clk),
    .Q(R0_DATA)
);

register8 r1 (
    .D(D),
    .EN(REG_EN[1]),
    .RST(RST),

  	.DEBUG_LOAD(DEBUG_LOAD && 		 DEBUG_REG_SEL == 3'b001),
    .DEBUG_VALUE(DEBUG_VALUE),

    .clk(clk),
    .Q(R1_DATA)
);

register8 r2 (
    .D(D),
    .EN(REG_EN[2]),
    .RST(RST),
  	.DEBUG_LOAD(DEBUG_LOAD && 		 DEBUG_REG_SEL == 3'b010),
    .DEBUG_VALUE(DEBUG_VALUE),
  
    .clk(clk),
    .Q(R2_DATA )
);

register8 r3 (
    .D(D),
    .EN(REG_EN[3]),
    .RST(RST),
  	.DEBUG_LOAD(DEBUG_LOAD && 		 DEBUG_REG_SEL == 3'b011),
    .DEBUG_VALUE(DEBUG_VALUE),
  
    .clk(clk),
    .Q(R3_DATA )
);

register8 r4 (
    .D(D),
    .EN(REG_EN[4]),
    .RST(RST),
  	.DEBUG_LOAD(DEBUG_LOAD && 		 DEBUG_REG_SEL == 3'b100),
    .DEBUG_VALUE(DEBUG_VALUE),
  
    .clk(clk),
    .Q(R4_DATA )
);

register8 r5 (
    .D(D),
    .EN(REG_EN[5]),
    .RST(RST),
  	.DEBUG_LOAD(DEBUG_LOAD && 		 DEBUG_REG_SEL == 3'b101),
    .DEBUG_VALUE(DEBUG_VALUE),
  
    .clk(clk),
    .Q(R5_DATA )
);

register8 r6 (
    .D(D),
    .EN(REG_EN[6]),
  	.RST(RST),
  	.DEBUG_LOAD(DEBUG_LOAD && 		 DEBUG_REG_SEL == 3'b110),
    .DEBUG_VALUE(DEBUG_VALUE),
    .clk(clk),
    .Q(R6_DATA )
);

register8 r7 (
    .D(D),
    .EN(REG_EN[7]),
    .RST(RST),
  	.DEBUG_LOAD(DEBUG_LOAD && 		 DEBUG_REG_SEL == 3'b111),
    .DEBUG_VALUE(DEBUG_VALUE),
    .clk(clk),
    .Q(R7_DATA )
);

assign QA =
    (READ_SEL_A == 3'b000) ? R0_DATA :
    (READ_SEL_A == 3'b001) ? R1_DATA :
    (READ_SEL_A == 3'b010) ? R2_DATA :
    (READ_SEL_A == 3'b011) ? R3_DATA :
    (READ_SEL_A == 3'b100) ? R4_DATA :
    (READ_SEL_A == 3'b101) ? R5_DATA :
    (READ_SEL_A == 3'b110) ? R6_DATA :
                            R7_DATA;

assign QB =
    (READ_SEL_B == 3'b000) ? R0_DATA :
    (READ_SEL_B == 3'b001) ? R1_DATA :
    (READ_SEL_B == 3'b010) ? R2_DATA :
    (READ_SEL_B == 3'b011) ? R3_DATA :
    (READ_SEL_B == 3'b100) ? R4_DATA :
    (READ_SEL_B == 3'b101) ? R5_DATA :
    (READ_SEL_B == 3'b110) ? R6_DATA :
                            R7_DATA;

endmodule
