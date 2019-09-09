module Pipeline #(parameter bus = 16, dir = 4, reg_num = 2**dir) 
	(
        input logic clk,
		input logic[bus-1:0] Input,
		output logic [bus-1:0] Output
	);

	logic [bus-1:0] pipe;
    
    always_ff @(posedge clk) begin
		Output <= pipe;
	end
	always_ff @(negedge clk) begin
		pipe <= Input;
	end

endmodule
