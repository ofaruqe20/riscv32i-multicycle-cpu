module register_n 
#(parameter WIDTH = 8)
(
input wire reset,
input wire clock,
input enable,
input wire [WIDTH-1:0] D,
output reg [WIDTH-1:0] Q
);

always@(posedge clock or negedge reset) begin

	if(reset) begin
		Q <= '0;
	end
	
	else begin
		if(enable) 
			Q <= D;
		else
			Q <= Q;
	end

end

endmodule 
