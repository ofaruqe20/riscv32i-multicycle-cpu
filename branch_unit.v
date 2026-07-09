module branch_unit (
input wire Branch,
input wire [3:0] flags,
input wire [2:0] funct3,
output reg taken
);

wire z, n, c, v;
assign z = flags[3];
assign n = flags[2];
assign c = flags[1];
assign v = flags[0];

always @(*) begin

	case (funct3) 
     	  	 3'b000: taken = Branch & z;         // beq

     	 	 3'b001: taken = Branch & ~z;        // bne

      	 	 3'b100: taken = Branch & (n ^ v);   // blt

      	 	 3'b101: taken = Branch & ~(n ^ v);  // bge

      	  	 3'b110: taken = Branch & ~c;        // bltu

     		 3'b111: taken = Branch & c;         // bgeu

     	  	 default: taken = 1'b0;
	endcase


end


endmodule 