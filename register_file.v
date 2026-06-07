module register_file(reset,clock,we3,a1,a2,a3,wd3,rd1,rd2);
   
   input reset;
   input clock;
   input we3; // write-enable
   input [4:0] a1; // register address 1
   input [4:0] a2; // register address 2
   input [4:0] a3; // register address 3
   input [31:0] wd3; // write data
   output [31:0] rd1; // read register 1
   output [31:0] rd2; // read register 2


   reg [31:0] registers [0:31]; // 32 32-bit registers
              integer i;
	
	
    // Asynchronous reset
    always @ (posedge clock or posedge reset)
    begin
        if (reset) begin
            // Set the entire register array to zero
 
            for (i = 0; i < 32; i = i + 1) 
				begin
                registers[i] <= 32'b0;
            end
        end
        else if (we3)
            registers[a3] <= wd3;
    end

    // Assigning output registers
    assign rd1 = (a1 == 5'b00000) ? 32'b0 : registers[a1];
    assign rd2 = (a2 == 5'b00000) ? 32'b0 : registers[a2];
    // rd1 = 0, rd2 = 0, means when addess = 0, register[0] = x0 is hardwired to 0
endmodule
