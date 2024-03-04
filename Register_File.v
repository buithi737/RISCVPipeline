module Register_File (CLK, Rst, WE3, WD3, A1, A2, A3, RD1, RD2);
	input CLK, Rst, WE3;
	input [4:0] A1, A2, A3;
	input [31:0] WD3;
	output [31:0] RD1, RD2;
	
	reg [31:0] Reg [31:0];
	
	always @(posedge CLK) begin
		if(WE3) begin
			Reg[A3] <= WD3;
		end
	end
	
	assign RD1 = (Rst == 0) ? 0 : Reg[A1];
	assign RD2 = (Rst == 0) ? 0 : Reg[A2];
	
	initial begin
		Reg[0] = 0;
	end
endmodule 
