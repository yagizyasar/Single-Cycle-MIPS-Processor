`timescale 1ns / 1ps
module alu(input logic [7:0] a, b, input logic opcode, output logic [7:0] result, logic zero);

	always_comb begin
		case (opcode)
			1'b0: result <= a + b;
			1'b1: 
				if (a == b) begin
					result <= 8'b0;
				end
				else begin
					result <= 8'b1;
				end
			default: result <= a + b;
		endcase
	end
	
	assign zero = (result == 8'b0);
	
endmodule