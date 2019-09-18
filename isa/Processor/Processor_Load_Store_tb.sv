`include "ProcessorStructs.sv" 

module Processor_Load_Store_tb();
	
	/*Entradas*/
	logic clk, rst;
	logic [31:0] instruction;
	logic [31:0] loadedData;
	logic [31:0] pcDir;
	
	/*Salidas*/
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

	Processor#(32,32,32) _proc(
	clk, 
	rst,
	instruction,
	loadedData,
	pcDir,
	storeData,
	addressData,
	PCout,
	MWE,
	MRE);
	
	
	initial begin
	pcDir = 32'b0000_0000_0000_0000_0000_0000_0000_0000;
	loadedData = 32'b0000000000000000_0000000000111111;
	clk = 1;
	rst = 1;
	
	//MOV R1,#9
	//R1 = 9
	instruction = 32'b0010_0001_0000_0000_000000000001001_1;
	#100;
	rst = 0;
	#100;
	

	
	
	
	//MOV R2,#4
	//R2 = 4
	instruction = 32'b0010_0010_0000_0000_000000000000100_1;
	#100;
	
	
	//MOV R3,#8
	//R3 = 8
	instruction = 32'b0010_0011_0000_0000_000000000001000_1;
	#100;
	
	
	
	/*
	
			Examples/memory.s
			=============
			ldr R1,[R2,R3] ;R1 = R2 - R3
			ldr R5,[R6,R7] ;R5 = R6 - R7

			str R1,[R2,R3] ;R1 = R2 - R3
			str R5,[R6,R7] ;R1 = R6 - R7


			=============
			compilation/memory.o
			=============
			0100 0001 0010 0011 0000000000000000
			0100 0101 0110 0111 0000000000000000
			0101 0001 0010 0011 0000000000000000
			0101 0101 0110 0111 0000000000000000
			=============
	
	*/
		/*instruction = 32'b0100_0001_0010_0011_0000000000000000;#100;
	
	 $display("ldr R1,[R2,R3]");
	 
	
  
		assert(storeData== 32'b00) $display("storeData Correcto"); else $error("ERROR storeData");
		assert(addressData== 32'b00) $display("addressData Correcto"); else $error("ERROR addressData");
		
		assert(PCout== 32'b0000000000000000_0000000000000100) $display("PCout Correcto"); else $error("ERROR PCout");
		assert(MWE ==  1'b0) $display("MWE Correcto"); else $error("ERROR MWE");
		assert(MRE ==  1'b0) $display("MRE Correcto"); else $error("ERROR MRE");
		
	
	
	instruction = 32'b0101_0001_0010_0011_0000000000000000;#100;*/
	
	 $display("str R1,[R2,R3]");
	instruction = 32'b0101_0001_0010_0011_0000000000000000;
	#100;
	/*Salidas*/
  
		assert(storeData== 32'b00) $display("storeData Correcto"); else $error("ERROR storeData");
		assert(addressData== 32'b00) $display("addressData Correcto"); else $error("ERROR addressData");
		
		assert(PCout== 32'b0000000000000000_0000000000000100) $display("PCout Correcto"); else $error("ERROR PCout");
		assert(MWE ==  1'b0) $display("MWE Correcto"); else $error("ERROR MWE");
		assert(MRE ==  1'b0) $display("MRE Correcto"); else $error("ERROR MRE");
		
		
		
	//MOV R2,#4
	//R2 = 2
	instruction = 32'b0010_0010_0000_0000_000000000000010_1;
	#100;
		
		
	$display("LDR R5,[R2,R3]");
	instruction = 32'b0100_0101_0010_0011_0000000000000000;
	#100;	
	
	
	
	//ADD R9,R5,R5
	//0000_1001_0000_1000_000000000000000_0
	//R9 = R5+R5 = 63+63 = 126
	instruction = 32'b0000_1001_0101_0101_000000000000000_0;
	#100;
	
	//ADD R8,R5,#4
	//0000_1001_0000_1000_000000000000000_0
	//R8 = R5+4 = 63+4 = 67
	instruction = 32'b0000_1000_0101_0000_000000000000100_1;
	#100;
	
	//ADD R10,R8,R9
	//0000_1001_0000_1000_000000000000000_0
	//R8 = R5+4 = 67+126 = 193
	instruction = 32'b0000_1010_1000_1001_000000000000000_0;
	#100;
	
	
	//Validar que se cargue la informacion de r5 antes 
	
	
	end
	
	
	
	always begin
		#50;
		clk = ~clk;
	end
	
	always begin
		#100;
		pcDir <= pcDir + 4;
	
	end
	

endmodule
	
	