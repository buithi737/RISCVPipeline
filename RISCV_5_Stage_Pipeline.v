module RISCV_5_Stage_Pipeline (CLK, Rst); 
	
	//Declare in/out
	input CLK, Rst;
	
	
	//Declare wire
	wire PCSrcE, RegWriteW, RegWriteE, ALUSrcE, MemWriteE, BranchE, JumpE, PCResultSrcE, RegWriteM, MemWriteM, WE3;
	wire [4:0] RD_W, RD_E, RS1_E, RS2_E, RD_M, A3;
	wire [2:0] ResultSrcE, DexControlE, ResultSrcM, DexControlM, ResultSrcW;
	wire [3:0] ALUControlE;
	wire [31:0] PCResultE, InstrD, PCD, PCPlus4D, ResultW, RD1_E, RD2_E, Imm_Ext_E, PCE, PCPlus4E, PCPlus4M, WriteDataM, ALU_ResultM, Imm_Ext_M, PCTargetM, 
	PCPlus4W, ALU_ResultW, TruncateResultW, Imm_Ext_W, PCTargetW, WD3;
	//Declare Module
	
	//Declare Fetch_Cycle
	Fetch_Cycle FC (.CLK(CLK), 
	                .Rst(Rst), 
						 .PCSrcE(PCSrcE), 
						 .PCResultE(PCResultE), 
						 .InstrD(InstrD), 
						 .PCD(PCD), 
						 .PCPlus4D(PCPlus4D));
	
	//Declare Decode_Cycle
	Decode_Cycle DC (.CLK(CLK), 
	                 .Rst(Rst), 
						  .InstrD(InstrD), 
						  .PCD(PCD), 
						  .PCPlus4D(PCPlus4D), 
					     .RegWriteW(WE3), 
					     .RDW(A3), 
						  .ResultW(WD3), 
						  .RegWriteE(RegWriteE), 
						  .ALUSrcE(ALUSrcE), 
						  .MemWriteE(MemWriteE), 
						  .ResultSrcE(ResultSrcE), 
						  .BranchE(BranchE), 
						  .JumpE(JumpE), 
						  .PCResultSrcE(PCResultSrcE), 
						  .ALUControlE(ALUControlE), 
						  .DexControlE(DexControlE), 
						  .RD1_E(RD1_E), 
						  .RD2_E(RD2_E), 
						  .Imm_Ext_E(Imm_Ext_E), 
						  .RD_E(RD_E), 
						  .PCE(PCE), 
						  .PCPlus4E(PCPlus4E), 
						  .RS1_E(RS1_E), 
						  .RS2_E(RS2_E));
	//Declare Execute_Cycle
	Execute_Cycle EXC (.CLK(CLK), 
							 .Rst(Rst), 
						    .RegWriteE(RegWriteE), 
							 .ALUSrcE(ALUSrcE), 
							 .MemWriteE(MemWriteE), 
							 .ResultSrcE(ResultSrcE), 
							 .BranchE(BranchE), 
							 .JumpE(JumpE), 
							 .PCResultSrcE(PCResultSrcE), 
							 .ALUControlE(ALUControlE), 
							 .DexControlE(DexControlE), 
							 .RD1_E(RD1_E), 
							 .RD2_E(RD2_E), 
							 .Imm_Ext_E(Imm_Ext_E), 
							 .RD_E(RD_E), 
							 .PCE(PCE), 
							 .PCPlus4E(PCPlus4E), 
							 .PCSrcE(PCSrcE), 
							 .PCResultE(PCResultE),
							 .RegWriteM(RegWriteM), 
							 .MemWriteM(MemWriteM), 
							 .ResultSrcM(ResultSrcM), 
							 .RD_M(RD_M), 
							 .PCPlus4M(PCPlus4M), 
							 .WriteDataM(WriteDataM), 
							 .ALU_ResultM(ALU_ResultM), 
						    .PCTargetM(PCTargetM), 
							 .Imm_Ext_M(Imm_Ext_M), 
							 .DexControlM(DexControlM));
	//Declare Memory_Cycle
	Memory_Cycle MC (.CLK(CLK), 
						  .Rst(Rst), 
						  .RegWriteM(RegWriteM), 
						  .MemWriteM(MemWriteM), 
						  .ResultSrcM(ResultSrcM), 
						  .DexControlM(DexControlM), 
						  .RD_M(RD_M),
						  .PCPlus4M(PCPlus4M), 
						  .WriteDataM(WriteDataM), 
					     .ALU_ResultM(ALU_ResultM), 
						  .Imm_Ext_M(Imm_Ext_M), 
						  .PCTargetM(PCTargetM),
					     .RegWriteW(RegWriteW), 
						  .ResultSrcW(ResultSrcW), 
					     .RD_W(RD_W), 
						  .PCPlus4W(PCPlus4W), 
						  .ALU_ResultW(ALU_ResultW), 
						  .TruncateResultW(TruncateResultW), 
						  .Imm_Ext_W(Imm_Ext_W), 
						  .PCTargetW(PCTargetW));

	//Declare Writeback_Cycle
	Writeback_Cycle WBC(.RegWriteW(RegWriteW), 
							  .ResultSrcW(ResultSrcW), 
							  .RD_W(RD_W), 
							  .PCPlus4W(PCPlus4W), 
							  .ALU_ResultW(ALU_ResultW), 
							  .TruncateResultW(TruncateResultW), 
							  .Imm_Ext_W(Imm_Ext_W), 
							  .PCTargetW(PCTargetW),
							  .WE3(WE3), 
							  .A3(A3), 
							  .WD3(WD3));
							
endmodule