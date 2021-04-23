`timescale 1ns / 1ps

module instruction_memory(input logic [4:0] address, output logic [15:0] instruction, nextInstruction);
	logic [15:0] instructionMemory[31:0]; 

 
    assign instructionMemory[0] = 16'b0001000000000111;
    assign instructionMemory[1] = 16'b0001000100000010;
    assign instructionMemory[2] = 16'b0010000000000000;
    assign instructionMemory[3] = 16'b0010000000010001;
    assign instructionMemory[4] = 16'b0011001000000000;
    assign instructionMemory[5] = 16'b0011001100000000;
    assign instructionMemory[6] = 16'b0011010000000001;
    assign instructionMemory[7] = 16'b1010100100100001;
    assign instructionMemory[8] = 16'b0100001100110000;
    assign instructionMemory[9] = 16'b0100001000100100;
    assign instructionMemory[10] = 16'b1010010100000000;
    assign instructionMemory[11] = 16'b0000000000110011;
    assign instructionMemory[12] = 16'b1110000000000000;

	assign instruction = instructionMemory[address];
	assign nextInstruction = instructionMemory[address + 1];
endmodule
