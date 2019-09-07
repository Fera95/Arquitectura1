module KernelBlur
	(
	input  logic [15:0] c [0:8],
	output logic [15:0] kadd_res
	);

	
	
	/*
	  [ 1, 1, 1]  1
	  [ 1, 1, 1] *-
	  [ 1, 1, 1]  8
	  
	*/
	
	logic [15:0] addition;
	assign addition = c[0]+c[1]+c[2]+c[3]+c[4]+c[5]+c[6]+c[7]+c[8];
	
	assign kadd_res = {addition[12:0],3'b0};
	
endmodule
