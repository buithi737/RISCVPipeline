module Truncate (ReadControl, Src, Result, DexControl);
	
	input [1:0] ReadControl;
	input [31:0] Src;
	input [2:0] DexControl;
	
	output reg [31:0] Result;
	
	always @(*) begin
		case (DexControl)
             3'b000: 
             begin
                case (ReadControl)
                2'b00: Result = {{24 {Src[7]}}, Src[7:0]};
                2'b01: Result = {{24 {Src[15]}}, Src[15:8]};
                2'b10: Result = {{24 {Src[23]}}, Src[23:16]};
                2'b11: Result = {{24 {Src[31]}}, Src[31:24]};
                default: Result = {32{1'bx}};
                endcase
             end
             
             3'b001: 
             begin
               case (ReadControl)
                2'b00: Result = {{16 {Src[15]}}, Src[15:0]};
                2'b01: Result = {{16 {Src[23]}}, Src[23:8]};
                2'b10: Result = {{16 {Src[31]}}, Src[31:16]};
                default: Result = {32{1'bx}};
                endcase
             end

             3'b010: Result = Src;
             
             3'b100:
             begin
                case (ReadControl)
                2'b00: Result = {{24 {1'b0}}, Src[7:0]};
                2'b01: Result = {{24 {1'b0}}, Src[15:8]};
                2'b10: Result = {{24 {1'b0}}, Src[23:16]};
                2'b11: Result = {{24 {1'b0}}, Src[31:24]};
                default: Result = {32{1'bx}};
                endcase
             end
             
             3'b101:
             begin
               case (ReadControl)
                2'b00: Result = {{16 {1'b0}}, Src[15:0]};
                2'b01: Result = {{16 {1'b0}}, Src[23:8]};
                2'b10: Result = {{16 {1'b0}}, Src[31:16]};
                default: Result = {32{1'bx}};
                endcase
             end
             
           default: Result = Src;
         endcase
	end
	
endmodule