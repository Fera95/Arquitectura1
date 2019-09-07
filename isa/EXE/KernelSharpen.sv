module KernelSharpen
	(
	input  logic [15:0] c [0:8],
	output logic [15:0] kadd_res
	);

	/*
	  [ 0,-1, 0] 
	  [-1, 5,-1]
	  [ 0,-1, 0]
	*/
	logic  [15:0] by5,addition;
	assign by5 = c[4] <<2 + c[4];
	assign addition = by5 - c[3] - c[5] - c[7] -c[1];
	assign kadd_res = (addition>16'hFF)? 16'hFF:addition;
	
endmodule
