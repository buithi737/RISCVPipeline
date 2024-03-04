module ALU (A, B, Result, ALUControl, Zero); 

	input [31:0] A, B;
	input [3:0] ALUControl;
	output reg [31:0] Result;
	output Zero;
	always @(*)
		case (ALUControl)
			4'b0000: Result = A + B; //add, addi
			4'b0001: Result = A - B; //sub, subi
			4'b0010: Result = A & B; //and, andi
			4'b0011: Result = A | B; //or, ori
			4'b0100: Result = A ^ B; // xor, xori
			4'b0101: Result = A < B; // sltu, sltiu
			4'b0110: begin					 //slt, slti
				if(A[31] == 1 && B[31] == 0)
					Result = 32'b00000000000000000000000000000001;
				else if (A[31] == 0 && B[31] == 1)
					Result = 32'b00000000000000000000000000000000;
				else
					Result = (A[30:0] < B[30:0]);
			end 
			4'b0111: Result = A << B; //sll, slli
			4'b1000: Result = A >> B; //srl, srli
			4'b1001: Result = A >>> B; //sra, srai
			default: Result = 0;
		endcase
	
	assign Zero = &(~Result);
endmodule