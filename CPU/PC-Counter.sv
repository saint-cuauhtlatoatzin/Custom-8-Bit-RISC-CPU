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
