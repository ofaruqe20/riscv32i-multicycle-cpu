module register_n
  #(parameter WIDTH = 8)
   (reset,clock,enable,D,Q);

   input reset;
   input clock;
   input enable;
   input [WIDTH-1:0] D;
   output reg [WIDTH-1:0] Q;
	
always @(posedge clock or posedge reset) 
begin
    if (reset) 
	 begin
      // Reset condition: Initialize Q to all 0's
      Q <= {WIDTH{1'b0}};
    end 
	 
	 else if (enable) 
	 begin
      // Enable condition: Assign D to Q on the rising edge of clock
      Q <= D;
    end
	 
	 else
	 
	 begin
	 	 
    // If enable = 0, Q maintains its current value
		Q<=Q;
	 
	 end 

  end
endmodule
