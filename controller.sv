`timescale 1ns / 1ps 

module controller( input logic clk, nextInstructionButton, switch, input logic [2:0] opCode, input logic immediateBit, 
					output logic writePc, memToReg, jumpEnable, aluCtrl, writeDst, writeFromIns, writeMemory, writeReg);
	
	always_comb begin
	if (nextInstructionButton || switch) begin
		case(opCode)
		3'b000: begin //store
			if (immediateBit == 0) begin 
				writePc <= 1;
				memToReg <= 0;
				jumpEnable <= 0;
				aluCtrl <= 0;
				writeDst <= 0;
				writeFromIns <= 0;
				writeMemory <= 1;
				writeReg <= 0;
			end else begin 
				writePc <= 1;
				memToReg <= 0;
				jumpEnable <= 0;
				aluCtrl <= 0;
				writeDst <= 1;
				writeFromIns <= 1;
				writeMemory <= 1;
				writeReg <= 0;
			end
		end
		3'b001:begin // load
			if (immediateBit == 0) begin 
				writePc <= 1;
				memToReg <= 1;
				jumpEnable <= 0;
				aluCtrl <= 0;
				writeDst <= 0;
				writeFromIns <= 0;
				writeMemory <= 0;
				writeReg <= 1;
			end else begin 
				writePc <= 1;
				memToReg <= 0;
				jumpEnable <= 0;
				aluCtrl <= 0;
				writeDst <= 1;
				writeFromIns <= 1;
				writeMemory <= 0;
				writeReg <= 1;
			end
		end
		3'b010: begin //addition
			writePc <= 1;
			memToReg <= 0;
			jumpEnable <= 0;
			aluCtrl <= 0;
			writeDst <= 1;
			writeFromIns <= 0;
			writeMemory <= 0;
			writeReg <= 1;
		end
		3'b101: begin //branch if equals
			writePc <= 1;
			memToReg <= 0;
			jumpEnable <= 1;
			aluCtrl <= 1;
			writeDst <= 0;
			writeFromIns <= 0;
			writeMemory <= 0;
			writeReg <= 0;
		end
		3'b111: begin //stop exec
			writePc <= 0;
			memToReg <= 0;
			jumpEnable <= 0;
			aluCtrl <= 0;
			writeDst <= 0;
			writeFromIns <= 0;
			writeMemory <= 0;
			writeReg <= 0;
		end 
		default: begin
			writePc <= 1;
			memToReg <= 0;
			jumpEnable <= 0;
			aluCtrl <= 0;
			writeDst <= 0;
			writeFromIns <= 0;
			writeMemory <= 0;
			writeReg <= 0;
		end
	endcase // opcode
	end else begin
	   writePc <= 1;
		memToReg <= 0;
		jumpEnable <= 0;
		aluCtrl <= 0;
	   writeDst <= 0;
		writeFromIns <= 0;
		writeMemory <= 0;
		writeReg <= 0;
	end
	end

endmodule