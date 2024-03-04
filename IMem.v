module IMem (Rst, A, RD);
	input Rst; 
	input [31:0] A;
	output [31:0] RD;
	reg [31:0] mem [1023:0];
	assign RD = (Rst == 0) ? 0 : mem[A[31:2]];
	
	initial begin
		mem[0] = 32'h0062E233;
		mem[1] = 32'h00B62423;
		mem[2] = 32'h00B61423;
	end
endmodule