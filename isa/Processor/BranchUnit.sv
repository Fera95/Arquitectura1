module BranchUnit #(parameter mbus = 32, parameter rbus = 32)
	(input  logic [mbus-1:0] currentPC,
	 input  logic [rbus-1:0] branchImm,
	 input  logic isBranch,
	 output logic [mbus-1:0] nextBranch
	);
	
	
	
	assign nextBranch = (isBranch) ? (currentPC + 4): branchImm; 
	
endmodule
