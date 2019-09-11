module ALU_tb ();

	/*Entradas*/
	
	logic [3:0] OPA, OPB;
	logic [23:0] cache [0:2] ;
	logic [1:0] FUNTYPE, FUNCODE,kernelReg;
	
	
	
	
	/*Salidas*/
	
	logic [3:0] result,operandB;
	logic [3:0] CPSR;
	/*
	
	module ALU #(parameter bus = 4) (
	input logic [bus-1:0] OPA, OPB, 
	input logic [1:0] kernelsel, 
	input logic [23:0] cache [0:2], 
	input logic [1:0] FUNTYPE, FUNCODE, 
	output logic [bus-1:0] result,
	output logic [3:0] CPSR, 
	output logic [bus-1:0] operandB);
	
	
	*/
		
	ALU #(4) _dut (OPA,OPB,kernelReg, cache, FUNTYPE, FUNCODE, result, CPSR, operandB);
	
	/*Se llena cache*/
 initial begin 
 
$readmemh("Tb_cache.txt", cache); 
 
 end
	
	 /*Se prueban las instrucciones*/

initial begin	
	


	 OPA = 3'b010;
	 OPB = 3'b001;
	 FUNTYPE = 2'b00;
	 FUNCODE = 2'b00;	
	 
	 kernelReg = 2'b00; #100;
	$display(" Valindando:ADD1 ");
   assert(result == 3'b011) $display("ADD1/result Correcto"); else $error("	ERROR ADD1/result");
	
	
	
	 OPA = 3'b111;
	 OPB = 3'b111;
	 FUNTYPE = 2'b00;
	 FUNCODE = 2'b00;	
	 
	 kernelReg = 2'b00;#100;
	$display(" Valindando:ADD2 ");
	assert(result == 4'b1110) $display("ADD2/result Correcto"); else $error("	ERROR ADD1/result");
   assert(CPSR == 4'b1000) $display("ADD2/Carry Correcto"); else $error("	ERROR ADD2/Carry");
	
	
end	
	
endmodule
