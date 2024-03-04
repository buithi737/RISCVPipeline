module Mux3 (D2, D1, D0, S, Y);
	input [31:0] D2, D1, D0;
	input [1:0] S;
	output [31:0] Y;
	
	assign Y = (S == 2) ? D2 :
				  (S == 1) ? D1 :
				  (S == 0) ? D0 : 0;
endmodule	