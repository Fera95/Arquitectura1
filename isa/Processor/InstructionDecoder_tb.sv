module InstructionDecoder_tb ();


			logic [31:0] instruction;
			logic [1:0] FUNTYPE, FUNCODE;
			logic [3:0] RDwb;
			logic WE, clk;
			logic [31:0] WBd, PCi;
			logic [31:0] OPA, OPB, STR_DATA, PCo, RKo;
			logic [3:0] RDo;
			logic selWB, selMEMRD, selMEMWR, selCPRS, selCACHEWR, selCACHESH, selBRANCH;
			
			
			/*Se instancia el decoder 
			
			
			module InstructionDecoder #(parameter bus = 32) (
			input logic [31:0] instruction,  
			input logic [bus-1:0] WBd, PCi,
			input logic [3:0] RDwb,
			input logic WE, clk,
			output logic [bus-1:0] OPA, OPB, STR_DATA, PCo, RKo, 
			output logic [3:0] RDo, 
			output logic [1:0] FUNTYPE, FUNCODE,
			output logic selWB, selMEMRD, selMEMWR, selCACHEWR, selCACHESH, selBRANCH);
			
			
			
			
			*/
			InstructionDecoder #(32) _DUT (instruction, WBd, PCi,RDwb,WE, clk, OPA, OPB, STR_DATA, PCo, RKo, RDo, FUNTYPE, FUNCODE, selWB, selMEMRD, selMEMWR, selCACHEWR, selCACHESH, selBRANCH);

		
			 /*Se prueban las instrucciones*/

initial begin	
	

		
		RDwb = 4'b1000; //r8
		WBd = 32'b0000000000000000000000000000000011;
		PCi = 32'b0000000000000000000000000000001100;
		WE = 1'b1;
				
		instruction = 32'b00100001000100110000000000000000;#100;//suma
	   $display("ADD");
      /*assert() $display("ADD/OPA Correcto"); else $error("ERROR ADD/OPA");
		assert() $display("ADD/OPB Correcto"); else $error("ERROR ADD/OPB");
		assert() $display("ADD/STR_DATA Correcto"); else $error("ERROR ADD/STR_DATA");
		assert() $display("ADD/PCo Correcto"); else $error("ERROR ADD/PCo");
		assert() $display("ADD/RKo Correcto"); else $error("ERROR ADD/RKo");
		assert() $display("ADD/RDo Correcto"); else $error("ERROR ADD/RDo");
		assert() $display("ADD/FUNTYPE Correcto"); else $error("ERROR ADD/FUNTYPE");
		assert() $display("ADD/FUNCODE Correcto"); else $error("ERROR ADD/FUNCODE");
		assert() $display("ADD/selWB Correcto"); else $error("ERROR ADD/selWB");
		assert() $display("ADD/selMEMRD Correcto"); else $error("ERROR ADD/selMEMRD");
		assert() $display("ADD/selCACHEWR Correcto"); else $error("ERROR ADD/selCACHEWR");
		assert() $display("ADD/selCACHESH Correcto"); else $error("ERROR ADD/selCACHESH");
		assert() $display("ADD/selBRANCH Correcto"); else $error("ERROR ADD/selBRANCH");*/
		
	
end	
			
endmodule
