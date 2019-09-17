`include "ProcessorStructs.sv" 

module MemWriteBackPipeline 
	(input logic clk, input mempipe i, output mempipe o);
	
	
	always_ff @(posedge clk) begin
		o <= i;
	
	end
	
endmodule
