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
		WBd = 32'b00000000000000000000000000000011;
		PCi = 32'b00000000000000000000000000001100;
		WE = 1'b1;
				
		instruction = 32'b00_00_0001_0001_0010_000000000000000_0;#100;//suma sin immediato
	   $display("ADD sin inmediato");
      assert(OPA==4'b0001) $display("ADD/OPA Correcto"); else $error("ERROR ADD/OPA");
		assert(OPB==4'b0001) $display("ADD/OPB Correcto"); else $error("ERROR ADD/OPB");
		assert(FUNTYPE== 2'b00) $display("ADD/FUNTYPE Correcto"); else $error("ERROR ADD/FUNTYPE");
		assert(FUNCODE== 2'b00) $display("ADD/FUNCODE Correcto"); else $error("ERROR ADD/FUNCODE");
		assert(selWB== 1'b1 ) $display("ADD/selWB Correcto"); else $error("ERROR ADD/selWB");
		assert(selMEMRD ==  1'b0) $display("ADD/selMEMRD Correcto"); else $error("ERROR ADD/selMEMRD");
		assert(selCACHEWR ==  1'b0) $display("ADD/selCACHEWR Correcto"); else $error("ERROR ADD/selCACHEWR");
		assert(selCACHESH ==  1'b0) $display("ADD/selCACHESH Correcto"); else $error("ERROR ADD/selCACHESH");
		assert(selBRANCH ==  1'b0) $display("ADD/selBRANCH Correcto"); else $error("ERROR ADD/selBRANCH");
		
	
end	
			
endmodule
