module FREQ_DIVIDER (input logic clk, reset,							 
							 output logic clk_out);		
always_ff @(posedge clk, posedge reset)
			if (reset) clk_out=0;
			else clk_out=~clk_out;
endmodule
