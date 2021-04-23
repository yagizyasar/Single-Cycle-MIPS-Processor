`timescale 1ns / 1ps

module top_module(input logic clk,
					input logic [4:0] buttons, 
					input logic [15:0] switches,
					output logic [15:0] leds,
					output logic [6:0] seg,
					output logic dp, 
					output logic [3:0] an);

	logic [7:0] sevSegDisplay;
	logic [3:0] sevSegAddress;
	logic [15:0] instruction, nextInstruction;

	logic reset, dispPrev, switch, dispNext, nextInstructionButton;

	debounce resetButton(clk, buttons[0], reset);
	debounce dispPrevButton(clk, buttons[1], dispPrev);
	debounce switchButton(clk, buttons[2], switch);
	debounce dispNextButton(clk, buttons[3], dispNext);
	debounce nextInsButton(clk, buttons[4], nextInstructionButton);


	always_ff @(posedge clk) begin
		if (reset) begin
			sevSegAddress <= 0;
		end else if (dispNext) begin 
			if (sevSegAddress == 4'b1111) begin
				sevSegAddress <= 4'b0000;
			end else begin 
				sevSegAddress <= sevSegAddress + 1;
			end
		end else if (dispPrev) begin 
			if (sevSegAddress == 4'b0000) begin
				sevSegAddress <= 4'b1111;
			end else begin 
				sevSegAddress <= sevSegAddress - 1;
			end
		end
	end


	datapath path(clk, reset, nextInstructionButton, switch, switches, sevSegAddress, writePc, memToReg, jumpEnable, aluCtrl, writeDst, writeFromIns, writeMemory, writeReg, 
	               instruction, nextInstruction, sevSegDisplay);
	               
	controller controllerUnit(clk, nextInstructionButton, switch, instruction[15:13], instruction[12], writePc, memToReg, jumpEnable, aluCtrl, writeDst, writeFromIns, writeMemory, writeReg);
	
	assign leds = instruction;
	
	SevSeg_4digit sevSeg(clk, sevSegAddress, 0, sevSegDisplay[7:4], sevSegDisplay[3:0], seg, dp, an);
	
	


endmodule
