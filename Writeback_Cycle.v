module Writeback_Cycle (RegWriteW, ResultSrcW, RD_W, PCPlus4W, ALU_ResultW, TruncateResultW, Imm_Ext_W, PCTargetW,
WE3, A3, WD3);
	
	//Declare in/out
	input RegWriteW;
	input [2:0] ResultSrcW;
	input [4:0] RD_W;
	input [31:0] PCPlus4W, ALU_ResultW, TruncateResultW, PCTargetW, Imm_Ext_W;

	output WE3;
	output [4:0] A3;
	output [31:0] WD3;
	
	//Declare wire
	wire [31:0] ResultW;
	
	//Declare Module
	Mux5 MUX5 (.D0(ALU_ResultW), 
				  .D1(TruncateResultW), 
				  .D2(PCPlus4W), 
				  .D3(PCTargetW), 
				  .D4(Imm_Ext_W), 
				  .S(ResultSrcW), 
				  .Y(ResultW));
	
	//Output Assignment
	assign WE3 = RegWriteW;
	assign A3 = RD_W;
	assign WD3 = ResultW;
	
endmodule