module Mux (D0, D1, S, Y);
	input [31:0] D0, D1;
	input S;
	output [31:0] Y;
	
	assign Y = (S == 0) ? D0 : D1;
endmodule
	