module Branch_tb ();
	logic [3:0] PC, Operand;
	logic [1:0] FUNTYPE, FUNCODE; 
	logic [3:0] CPSR; 
	logic [3:0] jumpAddress; 
	logic NOP;
	
	/*Se instancia módulo
	module Branch #(parameter bus = 4) 
	(input logic [bus-1:0] PC, Operand,
	input logic [1:0] FUNTYPE, FUNCODE, 
	input logic [3:0] CPSR, 
	
	output logic [bus-1:0] jumpAddress, 
	output logic NOP);
	
	*/
	
		
   Branch #(4) _dut2 (PC, Operand, FUNTYPE, FUNCODE, CPSR, jumpAddress, NOP);
	
	 
	 

initial begin	
	
		PC = 4'b0001;
		Operand = 4'b0010;
		FUNTYPE = 2'b10;
		FUNCODE = 2'b01;
		CPSR = 4'b0000;#100;
	   $display("Poner nombre de prueba aquí");
      $display(jumpAddress);
		$display(NOP);
		
	
end	
	
endmodule
