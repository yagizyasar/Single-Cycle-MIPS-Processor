`timescale 1ns / 1ps
module mux_2to1 #(parameter WIDTH = 8)(input logic [WIDTH-1:0] input1, input2,  input logic control, output logic [WIDTH-1:0] output1);
	assign output1 = control ? input2 : input1; 
endmodule