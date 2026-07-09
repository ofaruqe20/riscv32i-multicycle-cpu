module main_fsm(
input wire clock,
input wire reset,
input wire [6:0] op,
output reg [1:0] ALUSrcA,
output reg [1:0] ALUSrcB,
output reg [1:0] ResultSrc,
output reg AdrSrc,
output reg IRWrite,
output reg PCUpdate,
output reg RegWrite,
output reg MemWrite,
output reg [1:0] ALUOp,
output reg Branch
);

parameter [3:0]
    FETCH    = 4'd0,
    DECODE   = 4'd1,
    MEMADR   = 4'd2,
    MEMREAD  = 4'd3,
    MEMWB    = 4'd4,
    MEMWRITE = 4'd5,
    EXECUTER = 4'd6,
    ALUWB    = 4'd7,
    EXECUTEI = 4'd8,
    JAL      = 4'd9,
    BEQ      = 4'd10,
    LUI      = 4'd11,
    JALR     = 4'd12,
    JALRWB   = 4'd13,
    AUIPC    = 4'd14;



reg [3:0] state;
reg [3:0] next_state;

always@(posedge clock or posedge reset) begin

	if (reset) begin
		state <= FETCH;
		next_state <= FETCH;
	end

	else begin

	state <= next_state;

	end
end




always@(*) begin

case (state)
FETCH: begin 
next_state = DECODE; ALUSrcA = 2'b00; ALUSrcB = 2'b10; ResultSrc = 2'b10; AdrSrc = 1'b0; IRWrite = 1'b1; RegWrite = 1'b0; PCUpdate = 1'b1; MemWrite = 1'b0; ALUOp = 2'b00; Branch = 1'b0; end

DECODE: begin
	ALUSrcA = 2'b01; ALUSrcB = 2'b01; ResultSrc = 2'b00; AdrSrc = 1'b0; IRWrite = 1'b0; RegWrite = 1'b0; PCUpdate = 1'b0; MemWrite = 1'b0; ALUOp = 2'b00; Branch = 1'b0;
   
	 case(op)

        // Load Instructions (lw, lb, lh, lbu, lhu)
        7'b0000011: next_state = MEMADR;   // MemAdr

        // ALU Immediate Instructions
        // (addi, slti, sltiu, xori, ori, andi, slli, srli, srai)
        7'b0010011: next_state = EXECUTEI;   // ExecuteI

        // AUIPC
        7'b0010111: next_state = AUIPC;  // AUIPC

        // Store Instructions (sw, sh, sb)
        7'b0100011: next_state = MEMADR;   // MemAdr

        // ALU Register Instructions
        // (add, sub, and, or, xor, sll, srl, sra, slt, sltu)
        7'b0110011: next_state = EXECUTER;   // ExecuteR

        // LUI
        7'b0110111: next_state = LUI;  // LUI

        // Branch Instructions
        // (beq, bne, blt, bge, bltu, bgeu)
        7'b1100011: next_state = BEQ;  // Branch

        // JALR
        7'b1100111: next_state = JALR;  // JALR

        // JAL
        7'b1101111: next_state = JAL;   // JAL

        default: next_state = FETCH;      // Return to Fetch (or ERROR state)

    endcase

end


MEMADR: begin
next_state = (op == 7'b0000011) ? MEMREAD : MEMWRITE; ALUSrcA = 2'b10; ALUSrcB = 2'b01; ResultSrc = 2'b00; AdrSrc = 1'b0; IRWrite = 1'b0; RegWrite = 1'b0; PCUpdate = 1'b0; MemWrite = 1'b0; ALUOp = 2'b00; Branch = 1'b0; end

MEMREAD: begin
next_state = MEMWB; ALUSrcA = 2'b00; ALUSrcB = 2'b00; ResultSrc = 2'b00; AdrSrc = 1'b1; IRWrite = 1'b0; RegWrite = 1'b0; PCUpdate = 1'b0; MemWrite = 1'b0; ALUOp = 2'b00; Branch = 1'b0; end

MEMWB: begin
next_state = FETCH; ALUSrcA = 2'b00; ALUSrcB = 2'b00; ResultSrc = 2'b01; AdrSrc = 1'b0; IRWrite = 1'b0; RegWrite = 1'b1; PCUpdate = 1'b0; MemWrite = 1'b0; ALUOp = 2'b00; Branch = 1'b0; end

MEMWRITE: begin
next_state = FETCH; ALUSrcA = 2'b00; ALUSrcB = 2'b00; ResultSrc = 2'b00; AdrSrc = 1'b1; IRWrite = 1'b0; RegWrite = 1'b0; PCUpdate = 1'b0; MemWrite = 1'b1; ALUOp = 2'b00; Branch = 1'b0; end

EXECUTER: begin
next_state = ALUWB; ALUSrcA = 2'b10; ALUSrcB = 2'b00; ResultSrc = 2'b00; AdrSrc = 1'b0; IRWrite = 1'b0; RegWrite = 1'b0; PCUpdate = 1'b0; MemWrite = 1'b0; ALUOp = 2'b10; Branch = 1'b0; end

ALUWB: begin
next_state = FETCH; ALUSrcA = 2'b00; ALUSrcB = 2'b00; ResultSrc = 2'b00; AdrSrc = 1'b0; IRWrite = 1'b0; RegWrite = 1'b1; PCUpdate = 1'b0; MemWrite = 1'b0; ALUOp = 2'b00; Branch = 1'b0; end

EXECUTEI: begin
next_state = ALUWB; ALUSrcA = 2'b10; ALUSrcB = 2'b01; ResultSrc = 2'b00; AdrSrc = 1'b0; IRWrite = 1'b0; RegWrite = 1'b0; PCUpdate = 1'b0; MemWrite = 1'b0; ALUOp = 2'b10; Branch = 1'b0; end

JAL: begin
next_state = ALUWB; ALUSrcA = 2'b01; ALUSrcB = 2'b10; ResultSrc = 2'b00; AdrSrc = 1'b0; IRWrite = 1'b0; RegWrite = 1'b0; PCUpdate = 1'b1; MemWrite = 1'b0; ALUOp = 2'b00; Branch = 1'b0; end

BEQ: begin
next_state = FETCH; ALUSrcA = 2'b10; ALUSrcB = 2'b00; ResultSrc = 2'b00; AdrSrc = 1'b0; IRWrite = 1'b0; RegWrite = 1'b0; PCUpdate = 1'b0; MemWrite = 1'b0; ALUOp = 2'b01; Branch = 1'b1; end

LUI: begin
next_state = ALUWB; ALUSrcA = 2'b11; ALUSrcB = 2'b01; ResultSrc = 2'b00; AdrSrc = 1'b0; IRWrite = 1'b0; RegWrite = 1'b0; PCUpdate = 1'b0; MemWrite = 1'b0; ALUOp = 2'b00; Branch = 1'b0; end

JALR: begin
next_state = JALRWB; ALUSrcA = 2'b10; ALUSrcB = 2'b01; ResultSrc = 2'b10; AdrSrc = 1'b0; IRWrite = 1'b0; RegWrite = 1'b0; PCUpdate = 1'b1; MemWrite = 1'b0; ALUOp = 2'b00; Branch = 1'b0; end

JALRWB: begin
next_state = FETCH; ALUSrcA = 2'b01; ALUSrcB = 2'b10; ResultSrc = 2'b10; AdrSrc = 1'b0; IRWrite = 1'b0; RegWrite = 1'b1; PCUpdate = 1'b0; MemWrite = 1'b0; ALUOp = 2'b00; Branch = 1'b0; end

AUIPC: begin
next_state = ALUWB; ALUSrcA = 2'b01; ALUSrcB = 2'b01; ResultSrc = 2'b00; AdrSrc = 1'b0; IRWrite = 1'b0; RegWrite = 1'b0; PCUpdate = 1'b0; MemWrite = 1'b0; ALUOp = 2'b00; Branch = 1'b0; end

endcase

end


endmodule 