module RegisterBank_tb ();


	//Entradas
	
	logic [3:0] RD,RS,RX,RK;
	logic [31:0] WB,PCi;
	logic clk,WE,RE;
	
	//Salida
	
	logic [3:0] StrReg,RSd,RXd,RKd,PCo;
	
	
	/*
	Se instancia el módulo
	RegisterBank #(parameter bus = 32, dir = 4, reg_num = 2**dir) 
	(
		input logic[dir-1:0] RD,RS,RX,RK, 
		input logic[bus-1:0] WB,PCi, //RD value is WB 
		input logic clk,WE,RE, 
		output logic [bus-1:0] StrReg, RSd,RXd,RKd,PCo);
	*/

	
	 RegisterBank  dut(RD,RS,RX,RK,WB,PCi,clk,WE,RE,StrReg,RSd,RXd,RKd,PCo);
	
	initial begin	
	
	/*Se instancias las entradas*/
	
	
		$display("XX");
      /*
		
		assert() $display("/StrReg Correcto"); else $error("ERROR /StrReg");
		assert() $display("/RSd Correcto"); else $error("ERROR /RSd");
		assert() $display("/RXd Correcto"); else $error("ERROR /RXd");
		assert() $display("/RKd Correcto"); else $error("ERROR /RKd");
		assert() $display("/PCo Correcto"); else $error("ERROR /PCo");
		
		*/

	end
	
	
endmodule
