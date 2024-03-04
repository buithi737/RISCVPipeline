module ALU_Decoder (ALUOp, Funct3, Funct75, Op5, ALUControl, DexControl);

	input Op5, Funct75; 
	input [1:0] ALUOp;
	input [2:0] Funct3;
	output reg [3:0] ALUControl;
	output reg [2:0] DexControl;
	
	wire RtypeSub;
	
	assign RtypeSub = Funct75 & Op5; // Subtract signal 
	
	always @(*) begin
		case(ALUOp)
			2'b00:
			begin
			   ALUControl = 4'b0000; //Addition
			   case (Funct3)
			       3'b000: DexControl = 3'b000; //lb, sb
			       3'b001: DexControl = 3'b001; //lh, sh
			       3'b010: DexControl = 3'b010; //lw, sw
			       3'b100: DexControl = 3'b100; //lbu
			       3'b101: DexControl = 3'b101; //lhu
			       default: DexControl = 3'bxxx;
			   endcase
			end  

			2'b01: //Braches
			begin 
				DexControl = 3'b000;
				case (Funct3)
					3'b000: ALUControl = 4'b0001; //subtraction
					3'b001: ALUControl = 4'b0001; //subtraction
					3'b100: ALUControl = 4'b0110; //set less than
					3'b101: ALUControl = 4'b0110; //set less than
					3'b110: ALUControl = 4'b0101; //set less than unsigned
					3'b111: ALUControl = 4'b0101; //set less than unsigned
					default: ALUControl = 4'bxxxx;
				endcase
			end 
			default:
			begin
				DexControl = 3'b000;
				case (Funct3) //R-Type or I-Type
					3'b000:
						if (RtypeSub)
							ALUControl = 4'b0001; //sub
						else
							ALUControl = 4'b0000; //add, addi
					3'b001: ALUControl = 4'b0111; //sll, slli
					3'b010: ALUControl = 4'b0110; //slt, slti
					3'b011: ALUControl = 4'b0101; //sltu, sltiu
					3'b100: ALUControl = 4'b0100; //xor, xori
					3'b101: if(Funct75) 
								ALUControl = 4'b1000; //srl, srli
							  else
								ALUControl = 4'b1001; //sra, srai
					3'b110: ALUControl = 4'b0011; //or, ori
					3'b111: ALUControl = 4'b0010; //and, andi
					default: ALUControl = 4'bxxxx;
				endcase
			end
		endcase
		
	end
	
endmodule 