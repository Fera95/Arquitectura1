module processor_algorithm_tb();

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
	
	/*
	Se instancia una memoria de 32 bits , de instrucciones
	
	
	module DataMemory
	#(parameter filename = "zelda.hex")
	(
	input logic clk,
	input logic enable,
	input logic write_enable,
	input logic read_enable,
	input logic [13:0] address,
	input logic [31:0]input_data,
	output logic [31:0] output_data
		);
	*/

	
	
	DataMemory #("color.vga.o") _datamem(clk,1,0,MRE,PCout,storeData,loadedData);
	 
	 /*
	 Se crean memoria de imagenes 
	 
	module Memory
	#(parameter filename = "zelda.hex", parameter filename2= "standopawa4.hex" )
	(
	input logic clk,
	input logic enable,
	input logic write_enable,
	input logic read_enable,
	input logic [14:0] address,
	input logic [15:0]input_data,
	output logic [15:0] output_data
	);
	 
	 
	 */
	
	logic [14:0]address_mem;
	assign address_mem = {1'b1,addressData}; 
	
	Memory _mem(clk,1,MWE,MRE,address,storeData,loadedData);
	
	
	initial begin
	
		
	
	end
	
	
	
	always begin
		#25;
		clk = ~clk;
		pcDir <= pcDir + 4;
	end
	

endmodule
