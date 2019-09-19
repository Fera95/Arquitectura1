`include "ProcessorStructs.sv" 

module BranchUnit_tb();

	logic [mbus-1:0] currentPC;
	logic [rbus-1:0] branchImm;
	logic isBranch;
	logic isBeq;
	logic CPSR[3:0];
	logic [mbus-1:0] nextBranch;
	
/*
module BranchUnit #(parameter mbus = 32, parameter rbus = 32)
	(input  logic [mbus-1:0] currentPC,
	 input  logic [rbus-1:0] branchImm,
	 input  logic isBranch,
	 input  logic isBeq,
	 input  logic CPSR[3:0],
	 output logic [mbus-1:0] nextBranch
	);
	
	
	*/

	BranchUnit#(32,32) _branU(currentPC, branchImm,isBranch,isBeq,CPSR,nextBranch);
	
	
	initial begin
	
		//not a branch
		$display("No branch");
		currentPC = 32'b00000000000000000000000000001010;
		branchImm = 32'b00000000000000000000000000000100;;
		isBranch =  0;
		isBeq = 0;
		CPSR[0] = 0;
		assert(nextBranch == 32'b00000000000000000000000000001110) $display("No branch Correcto"); else $error("ERROR No branch");
		#100
		$display("B with z=0");
		//regular branch w/ zero = 0
		isBranch =  1;
		isBeq = 0;
		assert(nextBranch ==  32'b00000000000000000000000000000100) $display("B with z=0 Correcto"); else $error("ERROR B with z=0");
		#100
		$display("B with z=1");
		//regular branch w/ zero = 1
		CPSR[0] = 1;
		assert(nextBranch ==32'b00000000000000000000000000000100) $display("B with z=1 Correcto"); else $error("ERROR B with z=1");
		#100
		$display("BEQ with z=0");
		//conditional branch w/ zero = 0
		isBeq = 1;
		CPSR[0] = 0;
		assert(nextBranch ==32'b00000000000000000000000000001110) $display("BEQ with z=0 Correcto"); else $error("ERROR BEQ with z=0");
		#100
		$display("BEQ with z=1");
		//conditional branch w/ zero = 0
		CPSR[0] = 1;
		assert(nextBranch == 32'b00000000000000000000000000000100) $display("BEQ with z=1 Correcto"); else $error("ERROR BEQ with z=1");
		
	end
	

endmodule
	
	