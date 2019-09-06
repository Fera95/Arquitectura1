module ALU_tb ();
	logic [5:0] OPA, OPB, kernelReg, result, operandB;
	logic [15:0] cache;
	logic [1:0] FUNTYPE, FUNCODE;
	logic [3:0] CPSR;
	
		
	ALU #(4) _dut (OPA, OPB,kernelReg, cache, FUNTYPE, FUNCODE, result, CPSR, operandB);
	
	 
	 
	assign OPA = 6'b001001;
	assign OPB = 6'b001100;
	assign FUNTYPE = 2'b00;
	assign FUNCODE = 2'b01;	
	assign cache = '0;
	assign kernelReg = 6'b000000;
	
	
endmodule