module ALU_decoder(opb5,funct3,funct7b5,ALUOp,ALUControl);

   input opb5;
   input [2:0] funct3;
   input       funct7b5;
   input [1:0] ALUOp;
   output reg [3:0] ALUControl;
   wire [3:0] cnct;
   
assign cnct = {opb5,funct3}; ///concatanation between opb5 and func3

always@(*)begin

case (ALUOp)

	2'b00: ALUControl<=4'b0000;
	2'b01: ALUControl<=4'b0001;
	2'b10: 
		case(cnct)
		4'b0000: ALUControl<=4'b0000;
		4'b0001: 
			begin
			if (funct7b5 == 0)
				ALUControl<=4'b0110;
			else
				ALUControl<=ALUControl;
				//ALUControl<=4'bxxxx; //default
			end

		4'b0010: ALUControl<=4'b0101;
		4'b0011: ALUControl<=4'b1001;
		4'b0100: ALUControl<=4'b0100;
		4'b0101: 
			begin
			if (funct7b5 == 0)
				ALUControl<=4'b0111;
			else
				ALUControl<=4'b1000;
			end
		4'b0110: ALUControl<=4'b0011;
		4'b0111: ALUControl<=4'b0010;
		default: ALUControl<=ALUControl;
		//default: ALUControl<=4'bxxxx;
		endcase
	default: ALUControl<=ALUControl;
	//default: ALUControl<=4'bxxxx;
endcase
end

endmodule
