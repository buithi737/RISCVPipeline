module Mux5 (D0, D1, D2, D3, D4, S, Y);

	input [31:0] D0, D1, D2, D3, D4;
	input [2:0] S;
	
	output [31:0] Y;
	
	assign Y = (S == 0) ? D0 :
				  (S == 1) ? D1 :
				  (S == 2) ? D2 :
				  (S == 3) ? D3 :
				  (S == 4) ? D4 : 0;
	
endmodule