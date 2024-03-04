module Decode_Cycle (CLK, Rst, InstrD, PCD, PCPlus4D, 
							RegWriteW, RDW, ResultW, 
							RegWriteE, ALUSrcE, MemWriteE, ResultSrcE, BranchE, JumpE, PCResultSrcE, ALUControlE, 
							DexControlE, RD1_E, RD2_E, Imm_Ext_E, RD_E, PCE, PCPlus4E, RS1_E, RS2_E);

	//Declare in/out
	input CLK, Rst, RegWriteW;
	input [4:0] RDW;
	input [31:0] InstrD, ResultW, PCD, PCPlus4D;
	
	output RegWriteE, ALUSrcE, MemWriteE, BranchE, JumpE, PCResultSrcE;
	output [2:0] ResultSrcE, DexControlE;
	output [3:0] ALUControlE;
	output [31:0] RD1_E, RD2_E, Imm_Ext_E, PCE, PCPlus4E;
	output [4:0] RD_E, RS1_E, RS2_E;
	
	//Declare Wire
	wire RegWriteD, ALUSrcD, MemWriteD, BranchD, JumpD, PCResultSrcD;
	wire [2:0] ImmSrcD;
	wire [2:0] ResultSrcD, DexControlD;
	wire [3:0] ALUControlD;
	wire [31:0] RD1_D, RD2_D, Imm_Ext_D;
	
	
	//Declare Reg
	reg RegWriteD_r, ALUSrcD_r, MemWriteD_r, BranchD_r, JumpD_r, PCResultSrcD_r;
	reg [2:0] ResultSrcD_r, DexControlD_r; 
	reg [3:0] ALUControlD_r;
	reg [31:0] RD1_D_r, RD2_D_r, Imm_Ext_D_r, PCD_r, PCPlus4D_r;
	reg [4:0] RD_D_r, RS1_D_r, RS2_D_r;
	
	//Initial module
	//Declare Control Unit
	Control_Unit ControlUnit (.Opcode(InstrD[6:0]), 
									  .RegWrite(RegWriteD), 
									  .ImmSrc(ImmSrcD), 
									  .ALUSrc(ALUSrcD),  
									  .MemWrite(MemWriteD), 
									  .ResultSrc(ResultSrcD), 
									  .Branch(BranchD), 
									  .Funct3(InstrD[14:12]), 
									  .Funct75(InstrD[31:25]), 
									  .ALUControl(ALUControlD),
									  .Jump(JumpD), 
									  .PCResultSrc(PCResultSrcD), 
									  .DexControl(DexControlD));
									  
	//Declare Register File
	Register_File RegisterFile (.CLK(CLK), 
										 .Rst(Rst), 
										 .WE3(RegWriteW), 
										 .WD3(ResultW), 
										 .A1(InstrD[19:15]), 
										 .A2(InstrD[24:20]), 
										 .A3(RDW), 
										 .RD1(RD1_D), 
										 .RD2(RD2_D));
						
	//Declare Sign_Extend
	Sign_Extend Extended (.In(InstrD[31:7]), 
					 .ImmSrc(ImmSrcD), 
					 .Imm_Ext(Imm_Ext_D));
					 
	
	//Decode Cycle Register
	always @(posedge CLK or negedge Rst)begin 
		if(!Rst) begin
			RegWriteD_r <= 1'b0;
			ALUSrcD_r <= 1'b0;
			MemWriteD_r <= 1'b0;
			ResultSrcD_r <= 3'b000;
			BranchD_r <= 1'b0;
			JumpD_r <= 0;
			PCResultSrcD_r <= 0;
			ALUControlD_r <= 4'b000;
			DexControlD_r <= 3'b000;
			RD1_D_r <= 32'h00000000; 
			RD2_D_r <= 32'h00000000; 
			Imm_Ext_D_r <= 32'h00000000;
			RD_D_r <= 5'h00;
			PCD_r <= 32'h00000000; 
			PCPlus4D_r <= 32'h00000000;
			RS1_D_r <= 5'h00;
			RS2_D_r <= 5'h00;
		end
		else begin 
			RegWriteD_r <= RegWriteD;
         ALUSrcD_r <= ALUSrcD;
         MemWriteD_r <= MemWriteD;
         ResultSrcD_r <= ResultSrcD;
         BranchD_r <= BranchD;
			JumpD_r <= JumpD;
			PCResultSrcD_r <= PCResultSrcD;
         ALUControlD_r <= ALUControlD;
			DexControlD_r <= DexControlD;
         RD1_D_r <= RD1_D; 
         RD2_D_r <= RD2_D; 
         Imm_Ext_D_r <= Imm_Ext_D;
         RD_D_r <= InstrD[11:7];
         PCD_r <= PCD; 
         PCPlus4D_r <= PCPlus4D;
         RS1_D_r <= InstrD[19:15];
         RS2_D_r <= InstrD[24:20];
		end 
	end
	
	//Assign Outputs
	
	assign RegWriteE = RegWriteD_r;
	assign ALUSrcE = ALUSrcD_r;
	assign MemWriteE = MemWriteD_r;
	assign ResultSrcE = ResultSrcD_r; 
	assign BranchE = BranchD_r;
	assign JumpE = JumpD_r;
	assign PCResultSrcE = PCResultSrcD_r;
	assign ALUControlE = ALUControlD_r;
	assign DexControlE = DexControlD_r;
	assign RD1_E = RD1_D_r;
	assign RD2_E = RD2_D_r;
	assign Imm_Ext_E = Imm_Ext_D_r; 
	assign RD_E = RD_D_r; 
	assign PCE = PCD_r; 
	assign PCPlus4E = PCPlus4D_r;
	assign RS1_E = RS1_D_r;
	assign RS2_E = RS2_D_r;

endmodule
	
	
				
	
	
	
	
	
	
	
	
	
	
	
	
					 
					 
	
	
	