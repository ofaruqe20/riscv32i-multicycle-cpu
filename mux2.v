module mux2 
	#(parameter WIDTH = 8)
	(
	input wire [WIDTH-1:0] d0,
	input wire [WIDTH-1:0] d1,
	input sel,
	output reg [WIDTH-1:0] y
	);
	always@(*) 
		begin
		case (sel)
		1'b0: y = d0;
		1'b1: y = d1;
		endcase
		end
endmodule
