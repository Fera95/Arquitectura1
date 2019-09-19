/*
This module implements the branch unit that takes care of either performing a Jump to an address (either conditional or unconditional)
or just taking PC to PC + 4
*/

module BranchUnit #(parameter mbus = 32, parameter rbus = 32)
	(input  logic [mbus-1:0] currentPC,
	 input  logic [rbus-1:0] branchImm,
	 input  logic isBranch,
	 input  logic isBeq,
	 input  logic CPSR[3:0],
	 output logic [mbus-1:0] nextBranch
	);
	
	
	logic [mbus-1:0] tmpBranch;
	logic isB, shouldJump;
	
	assign  isB = isBranch && ~isBeq;
	assign shouldJump = isBeq && CPSR[0]; //if is BEQ and zero flag is activated 
	assign tmpBranch = (isB) ? branchImm:(currentPC + 4);  //if it is not BEQ and it is B then gives branch imm if it's not then gives PC+4
	assign nextBranch = (shouldJump) ? branchImm:tmpBranch; 
	
endmodule

