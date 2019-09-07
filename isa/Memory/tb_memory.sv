module tb_memory();
	logic clk,WE;
	logic [31:0] A;
	logic [7:0] WD,RD;
	
	// instantiate device to be tested 
	memory dut(clk,WE,A,WD,RD);
	
	// initialize test 
	initial 
		begin  
			A <= 0;
		end
		
	always 
		begin 
			clk <= 1; 
			# 5; 
			clk <= 0; 
			# 5;
		end
		
	always 
		begin 
		// Test write without Write Enabled
			# 10;
			A  <= 32'b00;
			WE <= 0;
			WD <= 2'h001;
			#10;
			A  <= 32'b00;
			
		// Write n to address[n]
			# 10; 
			A  <= 32'b00;
			WE <= 1;
			WD <= 2'h01;
			# 10; 
			A  <= 32'b01;
			WE <= 1;
			WD <= 2'h02;
			# 10; 
			A  <= 32'b10;
			WE <= 1;
			WD <= 2'h03;
			# 10;	
			
		// Read address[n]
			# 10; 
			A  <= 32'b00;
			WE <= 0;
			# 10; 
			A  <= 32'b01;
			# 10; 
			A  <= 32'b10;
			# 10;
			A  <= 32'b111;
			# 10;
			
		end

endmodule 