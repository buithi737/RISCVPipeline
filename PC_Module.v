module PC_Module(CLK, Rst, PC, PC_Next);
	input CLK, Rst;
	input [31:0] PC_Next;
	output reg [31:0] PC;
	
	always @(posedge CLK) begin
		if(Rst == 0) PC <= 0;
		else PC <= PC_Next;
	end 
endmodule 