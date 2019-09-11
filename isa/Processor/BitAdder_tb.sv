module BitAdder_tb ();

	logic OPA,OPB,carryIn;
	logic result,carryOut;
	
	
	/*
	Se instancia el módulo
	
	BitAdder (input logic OPA,OPB, carryIn, output logic result,carryOut);

	
	*/

	
	 BitAdder dut(OPA,OPB, carryIn, result,carryOut);
	
	initial begin	
	
	
	   OPA = 1'b1;
		OPB = 1'b0;
		carryIn = 1'b0;#100;
	
	   $display("1+0 sin carryIn");
      assert(result==1'b1) $display("1+0 sin carryIn/result Correcto"); else $error("ERROR 1+0 sin carryIn/result");
		assert(carryOut==1'b0) $display("1+0 sin carryIn/carryOut Correcto"); else $error("ERROR 1+0 sin carryIn/carryOut");
		
		OPA = 1'b1;
		OPB = 1'b0;
		carryIn = 1'b1;#100;
	
	   $display("1+0 con carryIn");
      assert(result==1'b0) $display("1+0 con carryIn/result Correcto"); else $error("ERROR 1+0 con carryIn/result");
		assert(carryOut==1'b1) $display("1+0 con carryIn/carryOut Correcto"); else $error("ERROR 1+0 con carryIn/carryOut");
		
		
		OPA = 1'b1;
		OPB = 1'b1;
		carryIn = 1'b0;#100;
	
	   $display("1+1 sin carryIn");
      assert(result==1'b0) $display("1+1 sin carryIn/result Correcto"); else $error("ERROR 1+1 sin carryIn/result");
		assert(carryOut==1'b1) $display("1+1 sin carryIn/carryOut Correcto"); else $error("ERROR 1+1 sin carry/carryOut");
		
		OPA = 1'b1;
		OPB = 1'b1;
		carryIn = 1'b1;#100;
	
	   $display("1+1 con carryIn");
      assert(result==1'b1) $display("1+1 con carryIn/result Correcto"); else $error("ERROR 1+1 con carryIn/result");
		assert(carryOut==1'b1) $display("1+1 con carryIn/carryOut Correcto"); else $error("ERROR 1+1 con carryIn/carryOut");
		
end
	
	
endmodule
