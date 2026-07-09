module ALU
(
input wire [31:0] A,
input wire [31:0] B,
input wire [3:0] ALUcontrol,
output reg [31:0] result,
output reg [3:0] flags
);

wire [31:0] invB;
reg [31:0] sum;
reg cout;
wire cd1, cd2, cd3, v, c, n, z;

assign cd1 = ((~ALUcontrol[3])&(~ALUcontrol[2])&(~ALUcontrol[1]))|((~ALUcontrol[3])&(~ALUcontrol[1])&(ALUcontrol[0]));
assign cd2 = A[31] ^ (sum[31]);
assign cd3 = ~(A[31]^ B[31] ^ result[31]);

assign z = (result ==  32'b0)? 1'b1 : 1'b0;
assign n = result[31];
assign v = cd1 & cd2 & cd3;
assign c = cd1 & cout;
assign flags[3:0] = {v,c,n,z};

assign invB = ~B;

always@(*) begin
	case(ALUcontrol)

	4'b0000: begin
	{cout, sum} = A + B;
	result = sum;
	end

	4'b0001: begin
	{cout, sum} = A + invB + 1'b1;
	result = sum;
	end

//	4'b0001: {cout, result} = A - B;

	4'b0010: result = A & B;
	
	4'b0011: result = A | B;

	4'b0100: result = A ^ B;

	4'b0101: begin
		 {cout, sum} = A + invB + 1'b1;
		 //result = {{31{1'b0}}, sum[31] ^ v};
		 result = sum[31] ^ v;
		 end
	4'b0110: result = A << B[4:0];

	4'b0111: result = A >> B[4:0];

	4'b1000: result = $signed (A) >>> B[4:0];

	4'b0101: begin
		 {cout, sum} = A + invB + 1'b1;
		 result = {{31{1'b0}}, ~cout};
		 end
	4'b0000: result = 32'bx;

	endcase
	end

endmodule
			

	
