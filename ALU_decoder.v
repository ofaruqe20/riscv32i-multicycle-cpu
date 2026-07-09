module ALU_decoder (
input wire opb5,
input wire [2:0] funct3,
input wire funct7b5,
input wire [1:0] ALUOp,
output reg [3:0] ALUControl
);

wire [4:0] control;

assign control = {opb5, funct3, funct7b5};

always@(*) begin

	case(ALUOp)
		2'b00: ALUControl = 4'b0000;
		
		2'b01: ALUControl = 4'b0001;
		
		2'b10: begin
			case(control)
				5'b00000: ALUControl = 4'b0000;	
				5'b00010: ALUControl = 4'b0110;	
				5'b00100: ALUControl = 4'b0101;	
				5'b00110: ALUControl = 4'b1001;	
				5'b01000: ALUControl = 4'b0100;	
				5'b01010: ALUControl = 4'b0111;	
				5'b01011: ALUControl = 4'b1000;	
				5'b01100: ALUControl = 4'b0011;	
				5'b01110: ALUControl = 4'b0010;	
				5'b10000: ALUControl = 4'b0000;	
				5'b10001: ALUControl = 4'b0001;	
				5'b10010: ALUControl = 4'b0110;	
				5'b10100: ALUControl = 4'b0101;
				5'b10110: ALUControl = 4'b1001;
				5'b11000: ALUControl = 4'b0100;	
				5'b11010: ALUControl = 4'b0111;	
				5'b11011: ALUControl = 4'b1000;	
				5'b11100: ALUControl = 4'b0011;		
				5'b11110: ALUControl = 4'b0010;		
				default: ALUControl = 4'b0000;
			endcase
			end

	default: ALUControl = 4'b0000;
	endcase


end
endmodule