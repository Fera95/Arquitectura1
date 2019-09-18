`include "ProcessorStructs.sv" 

module DecoExecPipeline 
	(input logic clk,rst, input idpipe i, output idpipe o);
	
	
	always_ff @(posedge clk) begin
		if (rst) o <= '0;
		else 
			o <= i;
	end
	
endmodule
