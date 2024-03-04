module Fetch_Cycle (CLK, Rst, PCSrcE, PCResultE, InstrD, PCD, PCPlus4D);

	//Declare in/out
	input CLK, Rst;
	input PCSrcE;
	input [31:0] PCResultE;
	output [31:0] InstrD, PCD, PCPlus4D;
	
	//Declare wire
	wire [31:0] PC_F, PCF, PCPlus4F;
	wire [31:0] InstrF;
	
	//Declare Register
	reg [31:0] InstrF_Reg, PCF_Reg, PCPlus4F_Reg;
	
	//Initation Module
	
	//Declare PC_MUX
	Mux PC_MUX (.D0(PCPlus4F), 
					.D1(PCResultE), 
					.S(PCSrcE), 
					.Y(PC_F));
	
	//Declare Program Counter
	PC_Module ProgramCounter (.CLK(CLK), 
										.Rst(Rst), 
										.PC(PCF), 
										.PC_Next(PC_F));
	
	//Declare Istruction Memory
	IMem InstructionMemory (.Rst(Rst), 
									.A(PCF), 
									.RD(InstrF));
	
	//Declare PC_Adder
	
	PC_Adder PCAdder (.A(PCF), 
							.B(32'd4), 
							.Result(PCPlus4F));
							
	//Fetch Cycle Register
	always @(posedge CLK or negedge Rst) begin
		if (Rst == 0) begin 
			InstrF_Reg <= 0;
			PCF_Reg <= 0;
			PCPlus4F_Reg <= 0;
		end
		else begin
			InstrF_Reg <= InstrF;
			PCF_Reg <= PCF;
			PCPlus4F_Reg <= PCPlus4F;
		end
	end
	
	//Assign Outputs
	assign InstrD = InstrF_Reg;
	assign PCD = PCF_Reg;
	assign PCPlus4D = PCPlus4F_Reg;
endmodule	