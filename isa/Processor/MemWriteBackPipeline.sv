`include "ProcessorStructs.sv" 

module MemWriteBackPipeline 
	(input logic clk,rst, input mempipe i, output mempipe o);
	
	
	always_ff @(posedge clk) begin
		if(rst) o<= '0;
		else 
			o <= i;
	
	end
	
endmodule
