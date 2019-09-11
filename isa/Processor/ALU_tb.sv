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
	

	/*ADD*/
	 OPA = 4'b0010;
	 OPB = 4'b0001;
	 FUNTYPE = 2'b00;
	 FUNCODE = 2'b00;	
	 
	 kernelReg = 2'b00; #100;
	$display(" Valindando:ADD1 ");
   assert(result == 3'b011) $display("ADD1/result Correcto"); else $error("	ERROR ADD1/result");
	
	
	
	/*SUB sin cero */
	 OPA = 4'b0011;
	 OPB = 4'b0001;
	 FUNTYPE = 2'b00;
	 FUNCODE = 2'b01;	
	 
	 kernelReg = 2'b00; #100;
	$display(" Valindando:SUB1 ");
   assert(result == 4'b0010) $display("SUB1/result Correcto"); else $error("	ERROR SUB1/result");
	assert(CPSR[0] == 1'b0) $display("SUB1/Cero Correcto"); else $error("	ERROR SUB1/Cero");
	
	/*SUB con cero */
	 OPA = 4'b0011;
	 OPB = 4'b0011;
	 FUNTYPE = 2'b00;
	 FUNCODE = 2'b01;	
	 
	 kernelReg = 2'b00; #100;
	$display(" Valindando:SUB2 ");
   assert(result == 4'b0000) $display("SUB2/result Correcto"); else $error("	ERROR SUB2/result");
	assert(CPSR[0] == 1'b1) $display("SUB2/Cero Correcto"); else $error("	ERROR SUB2/Cero");
end	
	
endmodule
