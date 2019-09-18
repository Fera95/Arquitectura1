`include "ProcessorStructs.sv" 

module ExecMemPipeline 
	(input logic clk,rst, input execpipe i, output execpipe o);
		
	
	always_ff @(posedge clk) begin
	   if(rst) o <= '0;
		else o <= i;
	
	end
	
endmodule
