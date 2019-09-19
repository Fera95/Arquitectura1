module topV_tb();

	logic clk, rst,seleccion,selVGA;
				 
	logic[7:0] r, g, b;
	logic o_hs, o_vs, o_sync, o_blank, o_clk;

	topV _t( clk, rst,seleccion,selVGA,r, g,b, o_hs, o_vs, o_sync, o_blank, o_clk);
				
	initial begin 

		rst = 1;
		selVGA = 0;
		clk = 1;
		#100;
		
		rst = 0;
		selVGA = 0;
		#100;
		
		

	end

	
	
	
	always begin
		clk = ~clk;
		#5;
	end
	


endmodule
