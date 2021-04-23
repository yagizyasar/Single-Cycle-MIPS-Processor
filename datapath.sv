`timescale 1ns / 1ps

module datapath(input logic clk, reset, next, switch,
				input logic [15:0] instructionFromSwitch, input logic [3:0] sevSegAddress, 
				input logic writePc, memToReg, jumpEnable, aluCtrl, writeDst, writeFromIns, writeMemory, writeReg,
					output logic [15:0] instruction, nextInstruction, output logic [7:0] sevSegDisplay);
	
	logic [3:0] writeAddressOfReg, addressOfMem;
	logic value, zero;
	logic [4:0] nextPc, pc;
	logic [7:0] readDataReg1, readDataReg2, writeDataToReg;
	logic [7:0] readDataMem, writeDataToMem, readDataMemMux;
	logic [7:0] aluResult;
	logic [15:0] instr, nextInstr;

    instruction_memory ROM(pc, instr, nextInstr);
    
    /*
     * Program Counter
     */
    always_comb begin
        if ( jumpEnable & zero ) begin
            nextPc = instruction[12:8];
        end
        else begin
            if (switch)
                 nextPc = pc;
            else if (next)
                 nextPc = pc + 1;
            else 
                nextPc = pc;
        end
    end

    always_ff @( posedge clk ) begin
        if (reset) begin
            pc <= 0;
        end
        else if (writePc) begin
            pc <= nextPc;
        end
    end

  
    always_comb begin
        if (switch) begin
             instruction = instructionFromSwitch;
        end
        else begin
            instruction = instr;
        end
    end

	//register file
	mux_2to1 #4 writeAddressReg(instruction[7:4], instruction[11:8], writeDst, writeAddressOfReg);
	mux_2to1 #8 writeDataReg(readDataMemMux, instruction[7:0], writeFromIns, writeDataToReg);
	register_file regFile(clk, reset, writeMemory, instruction[3:0], instruction[7:4], writeAddressOfReg, writeDataToReg, readDataReg1, readDataReg2);

	//alu
	alu alu(readDataReg1, readDataReg2, aluCtrl, aluResult, zero);

	//data memory
	mux_2to1 #8 writeDataMem(readDataReg1, instruction[7:0], writeFromIns, writeDataToMem);
	mux_2to1 #4 writeAddressMem(instruction[7:4], instruction[11:8], writeDst, addressOfMem);
	data_memory dataMem(clk, reset, writeMemory, addressOfMem, sevSegAddress, writeDataToMem, readDataMem, sevSegDisplay);
	mux_2to1 #8 readDataToMux(aluResult, readDataMem, memToReg, readDataMemMux);

endmodule