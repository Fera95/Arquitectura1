module Kernel_tb();
	logic [23:0] cache_in [0:2];
	logic [1:0]  Ksel;
	logic [15:0] kresult;
	Kernel _k(cache_in,ksel,kresult);

	
	initial begin
	
		//11	
		
		Ksel = 2'b00;
		cache_in[0] = {8'd11,8'd11,8'd11};
		cache_in[1] = {8'd11,8'd11,8'd11};
		cache_in[2] = {8'd11,8'd11,8'd11};	
		#10;
		
		
		//31
		Ksel = 2'b01;
		cache_in[0] = {8'd11,8'd11,8'd11};
		cache_in[1] = {8'd11,8'd15,8'd11};
		cache_in[2] = {8'd11,8'd11,8'd11};	
		#10;
		
		
		//110
		
		Ksel = 2'b10;
		cache_in[0] = {8'd11,8'd11,8'd11};
		cache_in[1] = {8'd11,8'd22,8'd11};
		cache_in[2] = {8'd11,8'd11,8'd11};	
		#10;
		
		
	
	end

	
endmodule

