module mux4
  #(parameter WIDTH = 8)
   (d0,d1,d2,d3,sel,y);

   input [WIDTH-1:0] d0;
   input [WIDTH-1:0] d1;
   input [WIDTH-1:0] d2;
   input [WIDTH-1:0] d3;
   input [1:0]	     sel;
   output reg [WIDTH-1:0] y;   
	
always @* begin
    case(sel)
        2'b00: y <= d0;
        2'b01: y <= d1;
        2'b10: y <= d2;
        2'b11: y <= d3;
        default: y <= y; // Default case, can be modified as per design requirements
    endcase
end

endmodule
