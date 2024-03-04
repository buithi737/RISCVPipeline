module Execute_Cycle (CLK, Rst, RegWriteE, ALUSrcE, MemWriteE, ResultSrcE, BranchE, JumpE, PCResultSrcE, 
ALUControlE, DexControlE, RD1_E, RD2_E, Imm_Ext_E, RD_E, PCE, PCPlus4E, PCSrcE, PCResultE, 
RegWriteM, MemWriteM, ResultSrcM, RD_M, PCPlus4M, WriteDataM, ALU_ResultM, PCTargetM, Imm_Ext_M, DexControlM);
	
	//Declare in/out
	input CLK, Rst;
	input RegWriteE, ALUSrcE, MemWriteE, BranchE, JumpE, PCResultSrcE;
	input [2:0] ResultSrcE, DexControlE; 
	input [3:0] ALUControlE;
	input [31:0] RD1_E, RD2_E, Imm_Ext_E, PCE, PCPlus4E;
	input [4:0] RD_E;
	
	
	output PCSrcE, RegWriteM, MemWriteM;
	output [31:0] PCTargetM, PCPlus4M, WriteDataM, ALU_ResultM, PCResultE, Imm_Ext_M;
	output [4:0] RD_M; 
	output [2:0] DexControlM, ResultSrcM;
	
	//Declare Wires
	wire [31:0] Src_B, ALUResultE;
	wire ZeroE;
	wire [31:0] PCTargetE;
	
	//Declare Reg
	reg RegWriteE_r, MemWriteE_r;
	reg [4:0] RD_E_r;
	reg [31:0] PCPlus4E_r, ALUResultE_r, PCTargetE_r, Imm_Ext_E_r;
	reg [31:0] RD2_E_r;
	reg [2:0] DexControlE_r, ResultSrcE_r;
	
	
	//Init module
	//Declare alu
	ALU Alu (.A(RD1_E), 
				.B(Src_B), 
				.Result(ALUResultE), 
				.ALUControl(ALUControlE), 
				.Zero(ZeroE)); 
	
	//Declare Mux
	Mux  MUX_ALUSrc (.D0(RD2_E), 
						  .D1(Imm_Ext_E), 
						  .S(ALUSrcE),
						  .Y(Src_B));
	
   Mux  MUX_PCResultSrc (.D0(PCTargetE), 
							    .D1(ALUResultE), 
							    .S(PCResultSrcE),
							    .Y(PCResultE)); 
	//Declare Adder
	PC_Adder Adder (.A(PCE), 
				       .B(Imm_Ext_E), 
				       .Result(PCTargetE));

	//Register logic
	always @(posedge CLK or negedge Rst) begin
		if(Rst == 0) begin
			RegWriteE_r <= 0;
			MemWriteE_r <= 0;
			ResultSrcE_r <=0;
			DexControlE_r <=0;
			RD_E_r <= 0;
			PCPlus4E_r <= 0;
			ALUResultE_r <= 0;
			Imm_Ext_E_r <= 0;
			RD2_E_r <= 0;
		   PCTargetE_r	<= 0;
		end
		else begin
			RegWriteE_r <= RegWriteE;
			MemWriteE_r <= MemWriteE;
			ResultSrcE_r <= ResultSrcE;
			DexControlE_r <= DexControlE;
			RD_E_r <= RD_E;
			PCPlus4E_r <= PCPlus4E;
			ALUResultE_r <= ALUResultE;
			Imm_Ext_E_r <= Imm_Ext_E;
			RD2_E_r <= RD2_E;
			PCTargetE_r <= PCTargetE;
		end
	end
	
	
	// Output Assign
	assign PCSrcE = JumpE|(ZeroE&BranchE) ;
	assign RegWriteM = RegWriteE_r;
	assign MemWriteM = MemWriteE_r;
	assign ResultSrcM = ResultSrcE_r;
	assign DexControlM = DexControlE_r;
	assign RD_M = RD_E_r;
	assign PCPlus4M = PCPlus4E_r;
	assign ALU_ResultM = ALUResultE_r;
	assign Imm_Ext_M = Imm_Ext_E_r;
	assign WriteDataM = RD2_E_r;
	assign PCTargetM = PCTargetE_r;
	
endmodule 