module decoder(

    input logic [15:0] INSTRUCTION,

    output logic [3:0] OPCODE,

    output logic [2:0] RD,
    output logic [2:0] RS1,
    output logic [2:0] RS2

);

always_comb begin

    OPCODE = INSTRUCTION[15:12];
    RD  = INSTRUCTION[11:9];
    RS1 = INSTRUCTION[8:6];
    RS2 = INSTRUCTION[5:3];

end

endmodule
