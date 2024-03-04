module Memory_Cycle (CLK, Rst, RegWriteM, MemWriteM, ResultSrcM, 
DexControlM, RD_M, PCPlus4M, WriteDataM, ALU_ResultM, Imm_Ext_M, PCTargetM,
RegWriteW, ResultSrcW, RD_W, PCPlus4W, ALU_ResultW, TruncateResultW, Imm_Ext_W, PCTargetW);

	//Declare in/out
	input CLK, Rst;
	input RegWriteM, MemWriteM;
	input [2:0] DexControlM, ResultSrcM;
	input [31:0] PCPlus4M, WriteDataM, ALU_ResultM, PCTargetM, Imm_Ext_M;
	input [4:0] RD_M; 
	
	
	output RegWriteW;
	output [2:0]  ResultSrcW;
	output [31:0] ALU_ResultW, PCPlus4W, TruncateResultW, Imm_Ext_W, PCTargetW;
	output [4:0] RD_W;
	
	//Declare wire
	wire [31:0] ReadDataM, TruncateResultM;
	//Declare reg 
	reg RegWriteM_r;
	reg [2:0] ResultSrcM_r;
	reg [31:0] ALU_ResultM_r, PCPlus4M_r, TruncateResultM_r, Imm_Ext_M_r, PCTargetM_r;
	reg [4:0] RD_M_r;
	//Declare Module 
	// Declare DMem
	Data_Memory DMem (.CLK(CLK), 
							.Rst(Rst), 
							.WE(MemWriteM), 
							.WD(WriteDataM), 
							.A(ALU_ResultM), 
							.RD(ReadDataM));
	
	//Declare Truncate
	Truncate Trunc (.ReadControl(ALU_ResultM[1:0]), 
				       .Src(ReadDataM), 
						 .Result(TruncateResultM), 
						 .DexControl(DexControlM));
							
	//Register Logic
	always @(posedge CLK or negedge Rst) begin 
		if(Rst == 0) begin
			RegWriteM_r <= 0;
			ResultSrcM_r <= 0;
			ALU_ResultM_r <= 0;
			PCPlus4M_r <= 0;
			TruncateResultM_r <= 0;
			Imm_Ext_M_r <= 0;
			PCTargetM_r <= 0;
			RD_M_r <= 0;
		end
		else begin
			RegWriteM_r <= RegWriteM;
			ResultSrcM_r <= ResultSrcM;
			ALU_ResultM_r <= ALU_ResultM;
			PCPlus4M_r <= PCPlus4M;
			TruncateResultM_r <= TruncateResultM;
			Imm_Ext_M_r <= Imm_Ext_M;
			PCTargetM_r <= PCTargetM;
			RD_M_r <= RD_M;
		end
	end
	
	// Output assign
	
	assign RegWriteW = RegWriteM_r;
	assign ResultSrcW = ResultSrcM_r;
	assign ALU_ResultW = ALU_ResultM_r;
	assign PCPlus4W = PCPlus4M_r;
	assign TruncateResultW = TruncateResultM_r;
	assign Imm_Ext_W = Imm_Ext_M_r;
	assign PCTargetW = PCTargetM_r;
	assign RD_W = RD_M_r;
	
endmodule 