module address_decoder (MemWrite,Addr,RAM_CS,RAM_WE,ROM_CS);

   input MemWrite;
   input [31:0] Addr;
   output reg	RAM_CS;
   output reg	RAM_WE;
   output reg	ROM_CS;

   // The memory map has non-volatile ROM (32 bits wide) from 
   // address 0x00000000 to 0x000003FF:
   // Bit number
   // 3    2    2    1    1    1    0    0
   // 1    7    3    9    5    1    7    3
   // 0000 0000 0000 0000 0000 0011 1111 1111 = 0x000003FF

   // The memory map has volatile RAM memory from
   // address 0x00000400 to address 0x0000004FF:
   // Bit number
   // 3    2    2    1    1    1    0    0
   // 1    7    3    9    5    1    7    3
   // 0000 0000 0000 0000 0000 0100 0000 0000 = 0x00000400
   // 0000 0000 0000 0000 0000 0100 1111 1111 = 0x000004FF
// Define memory address ranges

   parameter ROM_START_ADDR = 32'h00000000;
   parameter ROM_END_ADDR   = 32'h000003FF;
   parameter RAM_START_ADDR = 32'h00000400;
   parameter RAM_END_ADDR   = 32'h000004FF;

   // Decode logic
   always @* begin
       if (MemWrite) begin
           // Write operation
           if (Addr >= RAM_START_ADDR && Addr <= RAM_END_ADDR) begin
               // Address falls within RAM range
               RAM_CS <= 1'b1;
               RAM_WE <= 1'b1;  // RAM Write Enable
               ROM_CS <= 1'b0;  // ROM Chip Select
           end
           else begin
               // Address falls within ROM range or outside of memory map
               RAM_CS <= 1'b0;
               RAM_WE <= 1'b0;
               ROM_CS <= 1'b1;  // ROM Chip Select
           end
       end
       else begin
           // Read operation
           if (Addr >= ROM_START_ADDR && Addr <= ROM_END_ADDR) begin
               // Address falls within ROM range
               RAM_CS <= 1'b0;
               RAM_WE <= 1'b0;
               ROM_CS <= 1'b1;  // ROM Chip Select
           end
           else if (Addr >= RAM_START_ADDR && Addr <= RAM_END_ADDR) begin
               // Address falls within RAM range
               RAM_CS <= 1'b1;
               RAM_WE <= 1'b0;  // RAM Write Enable
               ROM_CS <= 1'b0;  // ROM Chip Select
           end
           else begin
               // Address falls outside of memory map
               RAM_CS <= 1'b0;
               RAM_WE <= 1'b0;
               ROM_CS <= 1'b0;
           end
       end
   end
endmodule
