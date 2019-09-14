module DecoExecPipeline 
	(input logic clk, input idpipe i, output idpipe o);
	
	
	always_ff @(posedge clk) begin
		o <= i;
	
	end
	
endmodule
