module Main_Decoder(Op, RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUOp, Jump, PCResultSrc);

	input [6:0] Op;
	output RegWrite, ALUSrc, MemWrite, Branch, PCResultSrc, Jump;
	output [1:0] ALUOp; 
	output [2:0] ImmSrc, ResultSrc;
	
	wire [13:0] Signal_Control; 
	
	assign Signal_Control = (Op == 7'b0000011) ? 14'b10001000100000 : //load
									(Op == 7'b0100011) ? 14'b00011100000000 : //store
									(Op == 7'b0110011) ? 14'b1xxx0000001000 : // R-type
									(Op == 7'b1100011) ? 14'b00100000010100 : // Branch
									(Op == 7'b0010011) ? 14'b10001000001000 :	//I-type
									(Op == 7'b1101111) ? 14'b10110001000010 : //Jal
									(Op == 7'b1100111) ? 14'b10001001000011 : //Jalr
									(Op == 7'b0010111) ? 14'b1100x00110xx00 :	//Auip
									(Op == 7'b0110111) ? 14'b1100x01000xx00 : 14'b00000000000000; //Lui
									
	assign {RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUOp, Jump, PCResultSrc} = Signal_Control;

endmodule

