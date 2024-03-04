`timescale 10ns/1ps

module Fetch_Cycle_tb ();
	reg CLK=0, Rst;
	reg PCSrcE;
	reg [31:0] PCTargetE;
	wire [31:0] InstrD, PCD, PCPlus4D;
	
	Fetch_Cycle DUT (CLK, Rst, PCSrcE, PCTargetE, InstrD, PCD, PCPlus4D);
	
	always begin
		CLK = ~ CLK;
		#50;
	end
	
	initial begin
		Rst <= 1'b0;
		#200
		Rst <= 1'b1;
		PCSrcE <= 0;
		PCTargetE <= 0;
		#500
		$finish;
	end
endmodule