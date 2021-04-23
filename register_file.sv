`timescale 1ns / 1ps
module register_file(input logic clk, reset, writeEnable, logic [3:0] readReg1, readReg2, writeReg3, logic [7:0] writeData3,
	output logic [7:0] readData1, readData2);

	logic [7:0] register[15:0];

	always_ff @(posedge clk) begin
	    if (reset) begin
	       for (int i = 0; i < 16; i++) begin
		      register[i] <= 8'b0;
	       end
	    end  else if (writeEnable) begin
			register[writeReg3] = writeData3;
		end
	end

	assign readData1 = register[readReg1];
	assign readData2 = register[readReg2];


endmodule