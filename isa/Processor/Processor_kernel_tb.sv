`include "ProcessorStructs.sv" 

module Processor_kernel_tb();
	
	logic clk, rst;
	logic [31:0] instruction;
	logic [31:0] loadedData;
	logic [31:0] pcDir;
	logic [31:0] storeData;
	logic [31:0] addressData;
	logic [31:0] PCout;
	logic MWE,MRE;
	
	/*
	
	module Processor 
	//idpl : InstructionDecodePipeLine
	//depl : DecodeExecutePipeLine
	#(parameter ibus = 32, rbus = 32, mbus = 32) 
	(
		input  logic clk, rst,
		input  logic [ibus-1:0] instruction,
		input  logic [mbus-1:0] loadedData,
		input  logic [mbus-1:0] pcDir,
		output logic [mbus-1:0] storeData,
		output logic [mbus-1:0] addressData,
		output logic [mbus-1:0] PCout,
		output logic MWE,MRE
	);

	
	*/

	Processor#(32,32,32) _proc(clk, rst,instruction,loadedData,pcDir,storeData,addressData,PCout,MWE,MRE);
		
	
	initial begin
	
	clk = 1;
	rst = 1;
	pcDir = 32'b0;

	
	#50;	
	rst = 0;
	#50;
	
	
	//LKN @blur
	instruction = 32'b1101_0000_000000000000000000000000;
	#50;
	
	//KRN R1
	instruction = 32'b1100_0001_000000000000000000000000;
	#50;
	
	//LKN @sharpen
	instruction = 32'b1101_0001_000000000000000000000000;
	#50;
	
	//KRN R2
	instruction = 32'b1100_0010_000000000000000000000000;
	#50;
	
	//LKN @oversharpen
	instruction = 32'b1101_0010_000000000000000000000000;
	#50;
	
	//KRN R3
	instruction = 32'b1100_0011_000000000000000000000000;
	#50;
	
	
	
	//MOV R4, #4 
	instruction = 32'b0010_0100_0000_0000000000000000100;
	#50;
	
	
	//LDK R4, 1
	instruction = 32'b1110_0100_0001_0000000000000000000;
	#50;
	
	//MOV R4, # 12
	instruction = 32'b0010_0100_0000_0000000000000001100;
	#50;
	
	//LDK R4, 2
	instruction = 32'b1110_0100_0010_0000000000000000000;
	#50;
	
	//MOV R4, # 3
	instruction = 32'b0010_0100_0000_0000000000000000011;
	#50;
	
	//LDK R4, 3
	instruction = 32'b1110_0100_0011_0000000000000000000;
	#50;
	
	//MOV R4, #15
	instruction = 32'b0010_0100_0000_0000000000000001111;
	#50;
	
	//LDK R4, 4
	instruction = 32'b1110_0100_0100_0000000000000000000;
	#50;
	
	//MOV R4, #2
	instruction = 32'b0010_0100_0000_0000000000000000010;
	#50;
	
	//LDK R4, 5
	instruction = 32'b1110_0100_0101_0000000000000000000;
	#50;
	
	//MOV R4, #1
	instruction = 32'b0010_0100_0000_0000000000000000001;
	#50;
	
	//LDK R4, 6
	instruction = 32'b1110_0100_0110_0000000000000000000;
	#50;
	

	
	//FOREACH (ROW IN CACHECOLOR) ROW << 8
	instruction = 32'b1111_0000000000000000000000000000;
	#50;
	
	//FOREACH (ROW IN CACHECOLOR) ROW << 8
	instruction = 32'b1111_0000000000000000000000000000;
	#50;
	
	//FOREACH (ROW IN CACHECOLOR) ROW << 8
	instruction = 32'b1111_0000000000000000000000000000;
	#50;
	
	//FOREACH (ROW IN CACHECOLOR) ROW << 8
	instruction = 32'b1111_0000000000000000000000000000;
	#50;
	
	//FOREACH (ROW IN CACHECOLOR) ROW << 8
	instruction = 32'b1111_0000000000000000000000000000;
	#50;
	
	//FOREACH (ROW IN CACHECOLOR) ROW << 8
	instruction = 32'b1111_0000000000000000000000000000;
	#50;
	
	//FOREACH (ROW IN CACHECOLOR) ROW << 8
	instruction = 32'b1111_0000000000000000000000000000;
	#50;
	
	//FOREACH (ROW IN CACHECOLOR) ROW << 8
	instruction = 32'b1111_0000000000000000000000000000;
	#50;
	
	//FOREACH (ROW IN CACHECOLOR) ROW << 8
	instruction = 32'b1111_0000000000000000000000000000;
	#50;
	
	
	end
	
	
	
	always begin
		#25;
		clk = ~clk;
		pcDir <= pcDir + 4;
	end
	

endmodule
	
	