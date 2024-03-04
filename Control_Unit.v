module Control_Unit (Opcode, RegWrite, ImmSrc, ALUSrc,  
							MemWrite, ResultSrc, Branch, Funct3, Funct75, 
							ALUControl, Jump, PCResultSrc, DexControl);
	
	input [6:0] Opcode;
	input [2:0] Funct3;
	input  Funct75;
	output RegWrite, ALUSrc, MemWrite, Branch, Jump, PCResultSrc;
	output [2:0] ImmSrc;
	output [2:0] ResultSrc, DexControl;
	output [3:0] ALUControl;
	
	wire [1:0] ALUOp;
	
	Main_Decoder MainDecoder(.Op(Opcode), 
									 .RegWrite(RegWrite), 
									 .ImmSrc(ImmSrc), 
									 .ALUSrc(ALUSrc), 
									 .MemWrite(MemWrite), 
									 .ResultSrc(ResultSrc), 
									 .Branch(Branch), 
									 .ALUOp(ALUOp),
									 .Jump(Jump),
									 .PCResultSrc(PCResultSrc));
	
	ALU_Decoder ALU_DECODER (.ALUOp(ALUOp), 
									 .Funct3(Funct3), 
									 .Funct75(Funct75), 
									 .Op5(Opcode[5]), 
									 .ALUControl(ALUControl),
									 .DexControl(DexControl));
					 
endmodule 