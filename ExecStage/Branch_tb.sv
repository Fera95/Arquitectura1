module Branch_tb ();
	logic [3:0] PC, Operand;
	logic [1:0] FUNTYPE, FUNCODE; 
	logic [3:0] CPSR; 
	logic [3:0] jumpAddress; 
	logic NOP;
	
		
   Branch #(4) _dut2 (PC, Operand, FUNTYPE, FUNCODE, CPSR, jumpAddress, NOP);
	
	 
	assign PC = 4'b0001;
	assign Operand = 4'b0010;
	assign FUNTYPE = 2'b10;
	assign FUNCODE = 2'b01;
	assign CPSR = 4'b0000;
	
	
endmodule