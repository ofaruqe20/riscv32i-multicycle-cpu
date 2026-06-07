module mux2
  #(parameter WIDTH = 8)
   (d0,d1,sel,y);

   input [WIDTH-1:0] d0;
   input [WIDTH-1:0] d1;
   input 	     sel;
   output [WIDTH-1:0] y;
   
  
assign y = (sel == 1'b0) ? d0 : d1;
 

endmodule
