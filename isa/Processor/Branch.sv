/*
 This modules describes the branch functionality it receives the PC register value and an operand to add to it and based on the function codes and the zero flag
 it gives the jump address relative to the PC

*/

module Branch #(parameter bus = 4) (input logic [bus-1:0] PC, Operand, input logic [1:0] FUNTYPE, FUNCODE, input logic [3:0] CPSR, output logic [bus-1:0] jumpAddress, output logic NOP);
	
	
	//Flags for adder
	logic carryOut, zero; 
	
	logic [bus-1:0] addResult;
	logic isBEQ, jump;
	
	Adder #(bus) _adder (PC,Operand, 1'b0, addResult, carryOut, zero);
	
	assign isBEQ = FUNCODE[0] && ~FUNCODE[1];
	
	assign jump = (isBEQ && CPSR[0]) | (~isBEQ);
	
	
	assign jumpAddress = jump?addResult:1'b0;
	
endmodule