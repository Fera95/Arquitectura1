`include "ProcessorStructs.sv" 

module ExecMemPipeline 
	(input logic clk, input execpipe i, output execpipe o);
	
	
	always_ff @(posedge clk) begin
		o <= i;
	
	end
	
endmodule
