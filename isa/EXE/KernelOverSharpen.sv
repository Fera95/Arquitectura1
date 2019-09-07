module KernelOverSharpen
	(
	input  logic [15:0] c [0:8],
	output logic [15:0] kadd_res
	);
	
	
	/*  
	  [-1,-1,-1]
	  [-1, 9,-1]
	  [-1 -1,-1]
	*/
	
	
	
	logic [15:0] by9, addition;
	
	assign by9 = (c[4] << 16'd3) + c[4];
	assign addition = by9-c[0]-c[1]+c[2]-c[3]-c[5]-c[6]-c[7]-c[8];
	assign kadd_res = (addition>16'hFF)? 16'hFF:addition;
	
	
	
endmodule
