`timescale 1 ns / 1 ns
module main_fsm(reset,clock,op,
	       ALUSrcA,ALUSrcB,ResultSrc,AdrSrc,
	       IRWrite,PCUpdate,RegWrite, MemWrite,
               ALUOp,Branch);

   input reset;
   input clock;
   input [6:0] op;
   output reg [1:0] ALUSrcA;
   output reg [1:0] ALUSrcB;
   output reg [1:0] ResultSrc;
   output reg	AdrSrc;
   output reg	IRWrite;
   output reg	PCUpdate;
   output reg	RegWrite;
   output reg	MemWrite;
   output reg [1:0] ALUOp;
   output reg	Branch;

   parameter FETCH = 0, DECODE = 1, MEMADR = 2, MEMREAD = 3, MEMWB = 4,
     MEMWRITE = 5, EXECUTER = 6, ALUWB = 7, EXECUTEI = 8, JAL = 9,
     BEQ = 10, LUI = 11, JALR = 12, JALRWB = 13, AUIPC = 14;
   
   reg [3:0] 	state, nextstate;
  
   // current state
   always @(posedge reset, posedge clock)
     begin
	if (reset == 1)
	  state <= FETCH;
	else
	  state <= nextstate;
     end
  
   // next state logic
   always @(state,op)
     case(state)
       FETCH: nextstate <= DECODE;
       DECODE: // Decode the opcode, op, to determine the next state
	 case(op)
		7'b0000011: nextstate <= MEMADR;
		7'b0010011: nextstate <= EXECUTEI;
		7'b0010111: nextstate <= AUIPC;
		7'b0100011: nextstate <= MEMADR;
		7'b0110011: nextstate <= EXECUTER;
		7'b0110111: nextstate <= LUI;
		7'b1100011: nextstate <= BEQ;
		7'b1100111: nextstate <= JALR;
		7'b1101111: nextstate <= JAL;
		default: nextstate <= FETCH;
		//default: nextstate <= 4'bx;
         endcase
	MEMADR:
	case(op)
            	7'b0000011: nextstate <= MEMREAD;
                7'b0100011: nextstate <= MEMWRITE;
                default: nextstate <= FETCH;
		//default: nextstate <= 4'bx;
        endcase	
       EXECUTER: nextstate <= ALUWB;
       EXECUTEI: nextstate <= ALUWB;
       JAL: nextstate <= ALUWB;
       LUI: nextstate <= ALUWB;
       JALR: nextstate <= JALRWB;
       AUIPC: nextstate <= ALUWB;
       //JALRWB: nextstate <= FETCH;
       MEMREAD: nextstate <= MEMWB;
       //BEQ: nextstate <= FETCH;
       //MEMWRITE: nextstate <= FETCH;
       //MEMWB: nextstate <= FETCH;
       //ALUWB: nextstate <= FETCH;
       default: nextstate <= FETCH;
	//default: nextstate <= 4'bx;
     endcase
    
   // output logic
   // assign ALUSrcA, ALUSrcB, ResultSrc, AdrSrc, IRWrite, PCUpdate, RegWrite, MemWrite, ALUOp, Branch
   always @(state)
     case(state)
       FETCH: 
	begin
	ALUSrcA<=#5 2'b00; ALUSrcB<=#5 2'b10; ResultSrc<=#5 2'b10; AdrSrc<=#5 1'b0; IRWrite<=#5 1'b1; PCUpdate<=#5 1'b1; RegWrite<=#5 1'b0; MemWrite<=#5 1'b0; ALUOp<=#5 2'b00; Branch<=#5 1'b0;
	end
       DECODE:
	begin
	ALUSrcA<=#5 2'b01; ALUSrcB<=#5 2'b01; ResultSrc<=#5 2'b00; AdrSrc<=#5 1'b0; IRWrite<=#5 1'b0; PCUpdate<=#5 1'b0; RegWrite<=#5 1'b0; MemWrite<=#5 1'b0; ALUOp<=#5 2'b00; Branch<=#5 1'b0;
	end
       MEMADR:
	begin
	ALUSrcA<=#5 2'b10; ALUSrcB<=#5 2'b01; ResultSrc<=#5 2'b00; AdrSrc<=#5 1'b0; IRWrite<=#5 1'b0; PCUpdate<=#5 1'b0; RegWrite<=#5 1'b0; MemWrite<=#5 1'b0; ALUOp<=#5 2'b00; Branch<=#5 1'b0;
	end
       MEMREAD:
	begin
	ALUSrcA<=#5 2'b00; ALUSrcB<=#5 2'b00; ResultSrc<=#5 2'b00; AdrSrc<=#5 1'b1; IRWrite<=#5 1'b0; PCUpdate<=#5 1'b0; RegWrite<=#5 1'b0; MemWrite<=#5 1'b0; ALUOp<=#5 2'b00; Branch<=#5 1'b0;
	end
       MEMWB:
	begin
	ALUSrcA<=#5 2'b00; ALUSrcB<=#5 2'b00; ResultSrc<=#5 2'b01; AdrSrc<=#5 1'b0; IRWrite<=#5 1'b0; PCUpdate<=#5 1'b0; RegWrite<=#5 1'b1; MemWrite<=#5 1'b0; ALUOp<=#5 2'b00; Branch<=#5 1'b0;
	end
       MEMWRITE:
	begin
	ALUSrcA<=#5 2'b00; ALUSrcB<=#5 2'b00; ResultSrc<=#5 2'b00; AdrSrc<=#5 1'b1; IRWrite<=#5 1'b0; PCUpdate<=#5 1'b0; RegWrite<=#5 1'b0; MemWrite<=#5 1'b1; ALUOp<=#5 2'b00; Branch<=#5 1'b0;
	end
       EXECUTER:
	begin
	ALUSrcA<=#5  2'b10; ALUSrcB<=#5  2'b00; ResultSrc<=#5  2'b00; AdrSrc<=#5  1'b0; IRWrite<=#5  1'b0; PCUpdate<=#5  1'b0; RegWrite<=#5  1'b0; MemWrite<=#5  1'b0; ALUOp<=#5  2'b10; Branch<=#5  1'b0;
	end
       ALUWB:
	begin
	ALUSrcA<=#5  2'b00; ALUSrcB<=#5  2'b00; ResultSrc<=#5  2'b00; AdrSrc<=#5  1'b0; IRWrite<=#5  1'b0; PCUpdate<=#5  1'b0; RegWrite<=#5  1'b1; MemWrite<=#5  1'b0; ALUOp<=#5  2'b00; Branch<=#5  1'b0;
	end
       EXECUTEI:
	begin
	ALUSrcA<=#5  2'b10; ALUSrcB<=#5  2'b01; ResultSrc<=#5  2'b00; AdrSrc<=#5  1'b0; IRWrite<=#5  1'b0; PCUpdate<=#5  1'b0; RegWrite<=#5  1'b0; MemWrite<=#5  1'b0; ALUOp<=#5  2'b10; Branch<=#5  1'b0;
	end
       JAL:
	begin
	ALUSrcA<=#5  2'b01; ALUSrcB<=#5  2'b10; ResultSrc<=#5  2'b00; AdrSrc<=#5  1'b0; IRWrite<=#5  1'b0; PCUpdate<=#5  1'b1; RegWrite<=#5  1'b0; MemWrite<=#5  1'b0; ALUOp<=#5  2'b00; Branch<=#5  1'b0;
	end
       BEQ:
	begin
	ALUSrcA<=#5  2'b10; ALUSrcB<=#5  2'b00; ResultSrc<=#5  2'b00; AdrSrc<=#5  1'b0; IRWrite<=#5  1'b0; PCUpdate<=#5  1'b0; RegWrite<=#5  1'b0; MemWrite<=#5  1'b0; ALUOp<=#5  2'b01; Branch<=#5  1'b1;
	end
       LUI:
	begin
	ALUSrcA<=#5  2'b11; ALUSrcB<=#5  2'b01; ResultSrc<=#5  2'b00; AdrSrc<=#5  1'b0; IRWrite<=#5  1'b0; PCUpdate<=#5  1'b0; RegWrite<=#5  1'b0; MemWrite<=#5  1'b0; ALUOp<=#5  2'b00; Branch<=#5  1'b0;
	end
       JALR:
	begin
	ALUSrcA<=#5  2'b10; ALUSrcB<=#5  2'b01; ResultSrc<=#5  2'b10; AdrSrc<=#5  1'b0; IRWrite<=#5  1'b0; PCUpdate<=#5  1'b1; RegWrite<=#5  1'b0; MemWrite<=#5  1'b0; ALUOp<=#5  2'b00; Branch<=#5  1'b0;
	end
       JALRWB:
	begin
	ALUSrcA<=#5  2'b01; ALUSrcB<=#5  2'b10; ResultSrc<=#5  2'b10; AdrSrc<=#5  1'b0; IRWrite<=#5  1'b0; PCUpdate<=#5  1'b0; RegWrite<=#5  1'b1; MemWrite<=#5  1'b0; ALUOp<=#5  2'b00; Branch<=#5  1'b0;
	end
       AUIPC:
	begin
	ALUSrcA<=#5  2'b01; ALUSrcB<=#5  2'b01; ResultSrc<=#5  2'b00; AdrSrc<=#5  1'b0; IRWrite<=#5  1'b0; PCUpdate<=#5  1'b0; RegWrite<=#5  1'b0; MemWrite<=#5  1'b0; ALUOp<=#5  2'b00; Branch<=#5  1'b0;
	end
       default:
	begin
	ALUSrcA<=#5  ALUSrcA; ALUSrcB<=#5  ALUSrcB; ResultSrc<=#5  ResultSrc; AdrSrc<=#5  AdrSrc; IRWrite<=#5  IRWrite; PCUpdate<=#5  PCUpdate; RegWrite<=#5  RegWrite; MemWrite<=#5  MemWrite; ALUOp<=#5  ALUOp; Branch<=#5  Branch;
	//ALUSrcA<=#5  2'bxx; ALUSrcB<=#5  2'bxx; ResultSrc<=#5  2'bxx; AdrSrc<=#5  1'bx; IRWrite<=#5  1'bx; PCUpdate<=#5  1'bx; RegWrite<=#5  1'bx; MemWrite<=#5  1'bx; ALUOp<=#5  2'bxx; Branch<=#5  1'bx;
	end
     endcase
          
endmodule
