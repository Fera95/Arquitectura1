/*
This module implements the instruction decoder which takes a 32 bits instruction and returns its decoded function type and code, its registers and 
its extended immediates as well as its immediate signal
*/

module InstructionDecoder #(parameter bus = 32) (input logic [31:0] instruction, output logic [1:0] FUNTYPE, FUNCODE , output logic [3:0] RD, RS, RX, output logic [bus-1:0] Imm4, Imm19, Imm28, output logic selimm);
	assign FUNTYPE  = instruction[31:30];
	assign FUNCODE  = instruction[29:28];
	assign RD = instruction[27:24];
	assign RS = instruction[23:20];
	assign RX = instruction[19:16];
	assign selimm = instruction[0];
	assign Imm4[3:0] = instruction[23:20];
	
	assign Imm19[18:0] = instruction[19:1];
	assign Imm28[27:0] = instruction[27:0];
	assign Imm4[bus-1:4] = '0;
	assign Imm28[bus-1:28] = '0;
	assign Imm19[bus-1:19] = '0;	
	
endmodule