module constant_32bit(y);
   parameter value = 32'd0;

   output [31:0] y;
	
assign y = value; //assigning y to a constant value 

endmodule
