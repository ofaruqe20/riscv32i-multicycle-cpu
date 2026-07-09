module address_decoder(
input wire MemWrite,
input wire [31:0] Addr,
output reg RAM_CS,
output reg RAM_WE,
output reg ROM_CS
);

always@(*) begin

if (Addr >= 32'h00000000 && Addr <= 32'h000003ff) begin

	RAM_CS = 1'b0;
	RAM_WE = 1'b0;
	ROM_CS = 1'b1;

end


else if (Addr >= 32'h00000400 && Addr <= 32'h000004FF) begin

	if (MemWrite == 1'b1) begin
		RAM_CS = 1'b1;
		RAM_WE = 1'b1;
		ROM_CS = 1'b0;
		end

	else begin
		RAM_CS = 1'b1;
		RAM_WE = 1'b0;
		ROM_CS = 1'b0;
		end

end

else 

	RAM_CS <= 1'b0;
	RAM_WE <= 1'b0;
	ROM_CS <= 1'b0;

end


endmodule