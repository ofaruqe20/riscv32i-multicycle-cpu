module load_store_unit (
input wire [2:0] funct3,
output reg [2:0] LoadType, 
output reg [1:0] StoreType
);

always@(*) begin

	case (funct3)
		3'b010: LoadType = 3'b000;
		3'b100: LoadType = 3'b001;
		3'b000: LoadType = 3'b010;
		3'b101: LoadType = 3'b011;
		3'b001: LoadType = 3'b100;
		default: LoadType = 3'b000;
	endcase
end


always@(*) begin

	case (funct3)
		3'b010: StoreType = 2'b00;
		3'b000: StoreType = 2'b01;
		3'b001: StoreType = 2'b10;
		default: StoreType = 2'b00;
	endcase

end

endmodule