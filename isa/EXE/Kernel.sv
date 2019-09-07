module Kernel
	(
	input  logic [23:0] cache_in [0:2],
	input  logic [1:0]  ksel,
	output logic [15:0] kresult
	);
	
	
	logic [23:0] row1,row2,row3;
			
	logic [15:0] add_row1,add_row2,add_row3,add_rows;
	
	logic [15:0] row1_col1,row1_col2,row1_col3;
	logic [15:0] row2_col1,row2_col2,row2_col3;
	logic [15:0] row3_col1,row3_col2,row3_col3;
	
	
		logic [15:0] kadd_res [0:8];

	/*
	K 00 blur
	K 01 sharpen
	K 10 over-sharp
	k 11 over-sharp
	
	  [ 1, 1, 1]  1
	  [ 1, 1, 1] *-
	  [ 1, 1, 1]  8
	  
	  [ 0,-1, 0] 
	  [-1, 5,-1]
	  [ 0,-1, 0]
	  
	  [-1,-1,-1]
	  [-1, 9,-1]
	  [-1 -1,-1]

	
	*/
	

	assign row1 = cache_in[0];
	assign row2 = cache_in[1];
	assign row3 = cache_in[2];

	
	assign row1_col1 = {8'b0,row1[7:0]};
	assign row1_col2 = {8'b0,row1[15:8]};
	assign row1_col3 = {8'b0,row1[23:16]};
	
	assign row2_col1 = {8'b0,row2[7:0]};
	assign row2_col2 = {8'b0,row2[15:8]};
	assign row2_col3 = {8'b0,row2[23:16]};
	
	assign row3_col1 = {8'b0,row3[7:0]};
	assign row3_col2 = {8'b0,row3[15:8]};
	assign row3_col3 = {8'b0,row3[23:16]};
	

	assign kadd_res[0] = row1_col1;
	assign kadd_res[1] = row1_col2;
	assign kadd_res[2] = row1_col3;
	
	assign kadd_res[3] = row2_col1;
	assign kadd_res[4] = row2_col2;
	assign kadd_res[5] = row2_col3;

	assign kadd_res[6] = row3_col1;	
	assign kadd_res[7] = row3_col2;
	assign kadd_res[8] = row3_col3;
	
	
	logic [15:0] blur_res, sharpen_res,oversharpen_res,blur_or_sharpen;
	
	KernelBlur        _blur(kadd_res,blur_res);
	KernelSharpen     _shrp(kadd_res,sharpen_res);
	KernelOverSharpen _oshp(kadd_res,oversharpen_res);
	
	assign blur_or_sharpen  = (ksel[0])?sharpen_res:blur_res;
	assign kresult = (ksel[1])?oversharpen_res: blur_or_sharpen;

endmodule
