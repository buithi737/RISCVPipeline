module Data_Memory(CLK, Rst, WE, WD, A, RD, DexControl);

	input CLK, Rst, WE;
	input [31:0] WD;
	input [7:0] A;
	input [2:0] DexControl;
	output [31:0] RD;
	reg [31:0] Mem [256];
	
	always @(posedge CLK) begin
		if(WE) 
			case(DexControl)
				3'b000: //sb
				begin 
					case(A[1:0])
						2'b00: Mem[A][7:0] <= WD[7:0];
						2'b01: Mem[A][15:8] <= WD[7:0]; 
						2'b10: Mem[A][23:16] <= WD[7:0]; 
						2'b11: Mem[A][31:24] <= WD[7:0]; 
					endcase
				end
				3'b001: //sh
				begin 
					case(A[1:0])
						2'b00: Mem[A][15:0] <= WD[15:0];
						2'b01: Mem[A][23:18] <= WD[15:0]; 
						2'b10: Mem[A][31:16] <= WD[15:0]; 
					endcase
				end
				default: Mem[A] <= WD;
			endcase
	end 
	
	assign RD = (!Rst) ? 32'b0 : Mem[A];

	initial begin 
		Mem[0] = 0;
	end
endmodule 