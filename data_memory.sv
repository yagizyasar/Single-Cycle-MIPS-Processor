`timescale 1ns / 1ps
module data_memory(input logic clk, reset, writeEnable, logic [3:0] address1, address2, logic [7:0] writeData,
					output logic [7:0] readData1, readData2);

	logic [7:0] memory[15:0];

	always_ff @(posedge clk) begin
	    if (reset) begin
	       for (int i = 0; i < 16; i++) begin
		      memory[i] <= 8'b0;
	       end
	    end  else if (writeEnable) begin
			memory[address1] = writeData;
		end
	end

	assign readData1 = memory[address1];
	assign readData2 = memory[address2]; // display for sevseg
endmodule