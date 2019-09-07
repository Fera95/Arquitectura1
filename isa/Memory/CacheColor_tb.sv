module CacheColor_tb();

	logic SH,clk,rst,WE;
	logic [15:0] di;
	logic [ 2:0] address;
	logic [23:0] cache_out [0:2];

	CacheColor _cach(SH,clk,rst,WE,di,address,cache_out);
	
	
	initial begin

	
		SH = 0;
		WE = 0;
		di = 16'd0;
		address = 0;
	
		clk = 1;
		rst = 1;
		
		#500;
		clk = 0;
		#500;
		
		
		SH = 0;
		WE = 1;
		di = 16'hFAFD;
		address = 0;		
		
		
		clk = 1;
		#500;
		clk = 0;
		#500;
		
		
		
		SH = 0;
		WE = 1;
		di = 16'hAABB;
		address = 1;
				
		clk = 1;
		#500;
		clk = 0;
		#500;
		
		
		SH = 0;
		WE = 1;
		di = 16'h9918;
		address = 2;
		
		
		clk = 1;
		#500;
		clk = 0;
		#500;
		
		
	
	
		SH = 0;
		WE = 1;
		di = 16'h7744;
		address = 3;
		
		
		clk = 1;
		#500;
		clk = 0;
		#500;
		
		SH = 0;
		WE = 1;
		di = 16'h33CC;
		address = 4;
		
		
		clk = 1;
		#500;
		clk = 0;
		#500;
		
		
		
		SH = 0;
		WE = 1;
		di = 16'h1155;
		address = 5;
		
		
		clk = 1;
		#500;
		clk = 0;
		#500;
		
		
		
		SH = 1;
		WE = 0;
		di = 16'h7744;
		address = 3;
		
		
		clk = 1;
		#500;
		clk = 0;
		#500;
		
		
		SH = 0;
		WE = 0;
		di = 16'h5454;
		address = 3;
		
		
		clk = 1;
		#500;
		clk = 0;
		#500;
		
		SH = 0;
		WE = 0;
		di = 16'h5454;
		address = 3;
		
		
		clk = 1;
		#500;
		clk = 0;
		#500;
		
		
		
		SH = 1;
		WE = 0;
		di = 16'h7474;
		address = 3;
		
		
		clk = 1;
		#500;
		clk = 0;
		#500;
		
		



		
		

	
	
	end
	
	
	
endmodule
