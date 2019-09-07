module CacheColor
	(
		input  logic SH,
		input  logic clk,
		input  logic rst,
		input  logic WE,
		input  logic [15:0] di,
		input  logic [ 2:0] address,
		output logic [23:0] cache_out [0:2]
	);
	
	logic [15:0] cache [0:5];
	
	
	always_ff @(posedge clk)begin
	
		if (SH == 1) begin
			cache[1] <= {cache[1][7:0],8'd0};
			cache[0] <= {cache[0][7:0],cache[1][15:8]};
			
			cache[3] <= {cache[3][7:0],8'd0};
			cache[2] <= {cache[2][7:0],cache[3][15:8]};
			
			cache[5] <= {cache[5][7:0],8'd0};
			cache[4] <= {cache[4][7:0],cache[5][15:8]};
			
		end
		else if (WE && ~SH)begin 
			cache[address] <= di;
		end
		cache_out[0] <= {cache[0],cache[1][15:8]}; 
		cache_out[1] <= {cache[2],cache[3][15:8]}; 
		cache_out[2] <= {cache[4],cache[5][15:8]}; 
		
	end
	
	
	
	
endmodule