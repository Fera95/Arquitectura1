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
	

	/*ADD sin carry*/
	 OPA = 4'b0010;
	 OPB = 4'b0001;
	 FUNTYPE = 2'b00;
	 FUNCODE = 2'b00;	
	 
	 kernelReg = 2'b00; #100;
	$display(" Valindando:ADD1 ");
   assert(result == 3'b011) $display("ADD1/result Correcto"); else $error("	ERROR ADD1/result");
	
	
	/*ADD con carry*/
	 OPA = 4'b0111;
	 OPB = 4'b0111;
	 FUNTYPE = 2'b00;
	 FUNCODE = 2'b00;	
	 
	 kernelReg = 2'b00;#100;
	$display(" Valindando:ADD2 ");
	assert(result == 4'b1110) $display("ADD2/result Correcto"); else $error("	ERROR ADD2/result");
   assert(CPSR == 4'b1000) $display("ADD2/Carry Correcto"); else $error("	ERROR ADD2/Carry");
	
	/*SUB sin negativo */
	 OPA = 4'b0011;
	 OPB = 4'b0001;
	 FUNTYPE = 2'b00;
	 FUNCODE = 2'b01;	
	 
	 kernelReg = 2'b00; #100;
	$display(" Valindando:SUB1 ");
   assert(result == 4'b0010) $display("SUB1/result Correcto"); else $error("	ERROR SUB1/result");
	
	/*SUB con negativo (chequear banderas)*/
end	
	
endmodule
