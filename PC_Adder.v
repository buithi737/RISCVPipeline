module PC_Adder (A, B, Result);
	input [31:0] A, B; 
	output [31:0] Result;
	assign Result = A + B;
endmodule 