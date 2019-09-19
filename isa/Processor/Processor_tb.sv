`include "ProcessorStructs.sv" 

module Processor_tb();
	
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
//MOV R1,#15
//R1 = 15
instruction = 32'b0010_0001_0000_0000000000000001111_1;

#50;	
rst = 0;
#50;


//MOV R1,#15
//R1 = 15
instruction = 32'b0010_0001_0000_0000000000000001111_1;
#50;


//MOV R5,R1
//R5 = 15
instruction = 32'b0010_0101_0000_0001_000000000000000_0;
#50;

//MOV R5,#5
//R5 = 5
instruction = 32'b0010_0101_0000_0000_000000000000101_1;
#50;

//ADD R6,R5,R1
//R6 = R5+R1 = 5+15 = 20
instruction = 32'b0000_0110_0101_0001_000000000000000_0;
#50;


//ADD R6,R6,R1
//R6 = R6+R1 = 20 + 15= 35
instruction = 32'b0000_0110_0110_0001_000000000000000_0;
#50;


//CMP R6,R6
//R6 = R6+R1 = 20 + 15= 35
instruction = 32'b0011_0110_0000_0110_000000000000000_0;
#50;

//SUB R6,R6,R1
//R6 = R6-R1 = 35 - 15= 20
instruction = 32'b0001_0110_0110_0001_000000000000000_0;
#50;







//MOV R8,#8
//0010_1000_0000_0000000000000001000_1
//R8 = 8
instruction = 32'b0010_1000_0000_0000000000000001000_1;
#50;


//MOV R0,#7
//0010 0000 0000 0000000000000000111 1
//R0 = 7
instruction = 32'b0010_0000_0000_0000000000000000111_1;
#50;

//MOV R9,R1
//0010 1001 0001 0000000000000000000 0
//R9 = R1 = 15
instruction = 32'b0010_1001_0000_0001_000000000000000_0;
#50;


//MOV R9,R9
//0010_1001_0000_1001_000000000000000_0
//R9 = R9 = 15
instruction = 32'b0010_1001_1001_0000000000000000000_0;
#50;


//CMP R9,#8
//0011_1001_0000_0000000000000001000_1

//Flag Zero  = 0
instruction = 32'b0011_1001_0000_0000000000000001000_1;
#50;


//CMP R9,#15
//0011_1001_0000_0000000000000001111_1
//Flag Zero  = 1
instruction = 32'b0011_1001_0000_0000000000000001111_1;
#50;


//CMP R9,R9
//0011_1001_0000_1001_000000000000000_0
//Flag Zero  = 1
instruction = 32'b0011_1001_0000_1001_000000000000000_0;
#50;



//CMP R9,R1
//0011_1001_0001_0000000000000000000_0
//Flag Zero  = 1
instruction = 32'b0011_1001_0001_0000000000000000000_0;
#50;



//CMP R9,R0
//0011_1001_0000_0000000000000000000_0
//Flag Zero  = 0
instruction = 32'b0011_1001_0000_0000000000000000000_0;
#50;






//SUB R9,R0,R8
//0011_1001_0000_1000_000000000000000_0

//R9 = R0-R8 = 7-8 = -1
instruction = 32'b0001_1001_0000_1000_000000000000000_0;
#50;



//SUB R9,R0,#6
//0011_1001_0000_0000000000000000110_1
//R9 = R0-R8 = 7-6 = 1
instruction = 32'b0001_1001_0000_0000000000000000110_1;
#50;


//SUB R9,R9,R1
//0011_1001_1001_0001_000000000000000_0
//R9 = R9-R1 = 1-15 = -14
instruction = 32'b0001_1001_1001_0001_000000000000000_0;
#50;



//ADD R9,R0,R8
//0000_1001_0000_1000_000000000000000_0
//R9 = R0-R8 = 7-8 = -1
instruction = 32'b0000_1001_0000_1000_000000000000000_0;
#50;



//ADD R9,R0,#6
//0000_1001_0000_0000000000000000110_1
instruction = 32'b0000_1001_0000_0000000000000000110_1;
#50;


//ADD R9,R9,R1
//0000_1001_1001_0001_000000000000000_0
instruction = 32'b0000_1001_1001_0001_000000000000000_0;
#50;



//MOV R9,#15
//0010 0001 0000 0000000000000001111 1
//R1 = 15
instruction = 32'b0010_1001_0000_0000000000000001111_1;
#50;



//LDK R9,#0
//1110_1001_0000_0000_000000000000000_0
instruction = 32'b1110_1001_0000_0000_000000000000000_0;
#50;

//LDK R9,#1
//1110_1001_0000_0000_000000000000000_0
instruction = 32'b1110_1001_0001_0000_000000000000000_0;
#50;


//LDK R9,#2
//1110_1001_0000_0000_000000000000000_0
instruction = 32'b1110_1001_0010_0000_000000000000000_0;
#50;


//LDK R9,#3
//1110_1001_0000_0000_000000000000000_0
instruction = 32'b1110_1001_0011_0000_000000000000000_0;
#50;


//LDK R9,#4
//1110_1001_0000_0000_000000000000000_0
instruction = 32'b1110_1001_0100_0000_000000000000000_0;
#50;

//LDK R9,#5
//1110_1001_0000_0000_000000000000000_0
instruction = 32'b1110_1001_0101_0000_000000000000000_0;
#50;





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
	instruction = 32'b0100_0001_0010_0011_0000000000000000;
	
	#50;

 $display("ldr R1,[R2,R3]");
 
	/*Salidas*/

	assert(storeData== 32'b00) $display("storeData Correcto"); else $error("ERROR storeData");
	assert(addressData== 32'b00) $display("addressData Correcto"); else $error("ERROR addressData");
	
	assert(PCout== 32'b0000000000000000_0000000000000100) $display("PCout Correcto"); else $error("ERROR PCout");
	assert(MWE ==  1'b0) $display("MWE Correcto"); else $error("ERROR MWE");
	assert(MRE ==  1'b0) $display("MRE Correcto"); else $error("ERROR MRE");
	


end
   


always begin
	#25;
	clk = ~clk;
	pcDir <= pcDir + 4;
end


endmodule
	
	