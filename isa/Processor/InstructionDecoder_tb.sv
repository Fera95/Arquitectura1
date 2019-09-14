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
				
		instruction = 32'b00_00_0001_0001_0010_000000000000000_0;#100;//suma 
	   $display("ADD");
  
		assert(FUNTYPE== 2'b00) $display("FUNTYPE Correcto"); else $error("ERROR FUNTYPE");
		assert(FUNCODE== 2'b00) $display("FUNCODE Correcto"); else $error("ERROR FUNCODE");
		
		assert(selWB== 1'b1 ) $display("selWB Correcto"); else $error("ERROR selWB");
		assert(selMEMRD ==  1'b0) $display("selMEMRD Correcto"); else $error("ERROR selMEMRD");
		assert(selMEMWR ==  1'b0) $display("selMEMWR Correcto"); else $error("ERROR selMEMWR");
		
		assert(selCACHEWR ==  1'b0) $display("selCACHEWR Correcto"); else $error("ERROR selCACHEWR");
		assert(selCACHESH ==  1'b0) $display("selCACHESH Correcto"); else $error("ERROR selCACHESH");
		assert(selBRANCH ==  1'b0) $display("selBRANCH Correcto"); else $error("ERROR  selBRANCH");
		
		
		instruction = 32'b00_01_0001_0001_0010_000000000000000_0;#100;//resta
	   $display("SUB");
     
		assert(FUNTYPE== 2'b00) $display("FUNTYPE Correcto"); else $error("ERROR FUNTYPE");
		assert(FUNCODE== 2'b01) $display("FUNCODE Correcto"); else $error("ERROR FUNCODE");
		
		assert(selWB== 1'b1 ) $display("selWB Correcto"); else $error("ERROR selWB");
		assert(selMEMRD ==  1'b0) $display("selMEMRD Correcto"); else $error("ERROR selMEMRD");
		assert(selMEMWR ==  1'b0) $display("selMEMWR Correcto"); else $error("ERROR selMEMWR");
		
		assert(selCACHEWR ==  1'b0) $display("selCACHEWR Correcto"); else $error("ERROR selCACHEWR");
		assert(selCACHESH ==  1'b0) $display("selCACHESH Correcto"); else $error("ERROR selCACHESH");
		assert(selBRANCH ==  1'b0) $display("selBRANCH Correcto"); else $error("ERROR  selBRANCH");
	
	
		instruction = 32'b00_10_0001_0001_0010_000000000000000_0;#100;//Move
	   $display("MOV");
     
		assert(FUNTYPE== 2'b00) $display("FUNTYPE Correcto"); else $error("ERROR FUNTYPE");
		assert(FUNCODE== 2'b10) $display("FUNCODE Correcto"); else $error("ERROR FUNCODE");
		
		assert(selWB== 1'b1 ) $display("selWB Correcto"); else $error("ERROR selWB");
		assert(selMEMRD ==  1'b0) $display("selMEMRD Correcto"); else $error("ERROR selMEMRD");
		assert(selMEMWR ==  1'b0) $display("selMEMWR Correcto"); else $error("ERROR selMEMWR");
		
		assert(selCACHEWR ==  1'b0) $display("selCACHEWR Correcto"); else $error("ERROR selCACHEWR");
		assert(selCACHESH ==  1'b0) $display("selCACHESH Correcto"); else $error("ERROR selCACHESH");
		assert(selBRANCH ==  1'b0) $display("selBRANCH Correcto"); else $error("ERROR  selBRANCH");
		
		instruction = 32'b00_11_0001_0001_0010_000000000000000_0;#100;//Compare
	   $display("CMP");
      
		assert(FUNTYPE== 2'b00) $display("FUNTYPE Correcto"); else $error("ERROR FUNTYPE");
		assert(FUNCODE== 2'b11) $display("FUNCODE Correcto"); else $error("ERROR FUNCODE");
		
		assert(selWB== 1'b0 ) $display("selWB Correcto"); else $error("ERROR selWB");
		assert(selMEMRD ==  1'b0) $display("selMEMRD Correcto"); else $error("ERROR selMEMRD");
		assert(selMEMWR ==  1'b0) $display("selMEMWR Correcto"); else $error("ERROR selMEMWR");
		
		assert(selCACHEWR ==  1'b0) $display("selCACHEWR Correcto"); else $error("ERROR selCACHEWR");
		assert(selCACHESH ==  1'b0) $display("selCACHESH Correcto"); else $error("ERROR selCACHESH");
		assert(selBRANCH ==  1'b0) $display("selBRANCH Correcto"); else $error("ERROR  selBRANCH");
		
		instruction = 32'b01_00_0001_0001_0010_000000000000000_0;#100;//LDR
	   $display("LDR");
      
		assert(FUNTYPE== 2'b01) $display("FUNTYPE Correcto"); else $error("ERROR FUNTYPE");
		assert(FUNCODE== 2'b00) $display("FUNCODE Correcto"); else $error("ERROR FUNCODE");
		
		assert(selWB== 1'b1 ) $display("selWB Correcto"); else $error("ERROR selWB");
		assert(selMEMRD ==  1'b1) $display("selMEMRD Correcto"); else $error("ERROR selMEMRD");
		assert(selMEMWR ==  1'b0) $display("selMEMWR Correcto"); else $error("ERROR selMEMWR");
		
		assert(selCACHEWR ==  1'b0) $display("selCACHEWR Correcto"); else $error("ERROR selCACHEWR");
		assert(selCACHESH ==  1'b0) $display("selCACHESH Correcto"); else $error("ERROR selCACHESH");
		assert(selBRANCH ==  1'b0) $display("selBRANCH Correcto"); else $error("ERROR  selBRANCH");
		
		
		instruction = 32'b01_01_0001_0001_0010_000000000000000_0;#100;//STR
	   $display("STR");
     
		assert(FUNTYPE== 2'b01) $display("FUNTYPE Correcto"); else $error("ERROR FUNTYPE");
		assert(FUNCODE== 2'b01) $display("FUNCODE Correcto"); else $error("ERROR FUNCODE");
		
		assert(selWB== 1'b0 ) $display("selWB Correcto"); else $error("ERROR selWB");
		assert(selMEMRD ==  1'b0) $display("selMEMRD Correcto"); else $error("ERROR selMEMRD");
		assert(selMEMWR ==  1'b1) $display("selMEMWR Correcto"); else $error("ERROR selMEMWR");
		
		assert(selCACHEWR ==  1'b0) $display("selCACHEWR Correcto"); else $error("ERROR selCACHEWR");
		assert(selCACHESH ==  1'b0) $display("selCACHESH Correcto"); else $error("ERROR selCACHESH");
		assert(selBRANCH ==  1'b0) $display("selBRANCH Correcto"); else $error("ERROR  selBRANCH");
		
		instruction = 32'b10_00_0001_0001_0010_000000000000000_0;#100;//B
	   $display("B");
      
		assert(FUNTYPE== 2'b10) $display("FUNTYPE Correcto"); else $error("ERROR FUNTYPE");
		assert(FUNCODE== 2'b00) $display("FUNCODE Correcto"); else $error("ERROR FUNCODE");
		
		assert(selWB== 1'b1 ) $display("selWB Correcto"); else $error("ERROR selWB");
		assert(selMEMRD ==  1'b0) $display("selMEMRD Correcto"); else $error("ERROR selMEMRD");
		assert(selMEMWR ==  1'b0) $display("selMEMWR Correcto"); else $error("ERROR selMEMWR");
		
		assert(selCACHEWR ==  1'b0) $display("selCACHEWR Correcto"); else $error("ERROR selCACHEWR");
		assert(selCACHESH ==  1'b0) $display("selCACHESH Correcto"); else $error("ERROR selCACHESH");
		assert(selBRANCH ==  1'b1) $display("selBRANCH Correcto"); else $error("ERROR  selBRANCH");
		
		
		instruction = 32'b10_01_0001_0001_0010_000000000000000_0;#100;//BEQ
	   $display("BEQ");
     
		assert(FUNTYPE== 2'b10) $display("FUNTYPE Correcto"); else $error("ERROR FUNTYPE");
		assert(FUNCODE== 2'b01) $display("FUNCODE Correcto"); else $error("ERROR FUNCODE");
		
		assert(selWB== 1'b1 ) $display("selWB Correcto"); else $error("ERROR selWB");
		assert(selMEMRD ==  1'b0) $display("selMEMRD Correcto"); else $error("ERROR selMEMRD");
		assert(selMEMWR ==  1'b0) $display("selMEMWR Correcto"); else $error("ERROR selMEMWR");
		
		assert(selCACHEWR ==  1'b0) $display("selCACHEWR Correcto"); else $error("ERROR selCACHEWR");
		assert(selCACHESH ==  1'b0) $display("selCACHESH Correcto"); else $error("ERROR selCACHESH");
		assert(selBRANCH ==  1'b1) $display("selBRANCH Correcto"); else $error("ERROR  selBRANCH");
		
		
		instruction = 32'b11_00_0001_0001_0010_000000000000000_0;#100;//KRN
	   $display("KRN");
      
		assert(FUNTYPE== 2'b11) $display("FUNTYPE Correcto"); else $error("ERROR FUNTYPE");
		assert(FUNCODE== 2'b00) $display("FUNCODE Correcto"); else $error("ERROR FUNCODE");
		
		assert(selWB== 1'b1 ) $display("selWB Correcto"); else $error("ERROR selWB");
		assert(selMEMRD ==  1'b0) $display("selMEMRD Correcto"); else $error("ERROR selMEMRD");
		assert(selMEMWR ==  1'b0) $display("selMEMWR Correcto"); else $error("ERROR selMEMWR");
		
		assert(selCACHEWR ==  1'b0) $display("selCACHEWR Correcto"); else $error("ERROR selCACHEWR");
		assert(selCACHESH ==  1'b0) $display("selCACHESH Correcto"); else $error("ERROR selCACHESH");
		assert(selBRANCH ==  1'b0) $display("selBRANCH Correcto"); else $error("ERROR  selBRANCH");
		
		
		instruction = 32'b11_01_0001_0001_0010_000000000000000_0;#100;//LKN
	   $display("LKN");
      
		assert(FUNTYPE== 2'b11) $display("FUNTYPE Correcto"); else $error("ERROR FUNTYPE");
		assert(FUNCODE== 2'b01) $display("FUNCODE Correcto"); else $error("ERROR FUNCODE");
		
		assert(selWB== 1'b0 ) $display("selWB Correcto"); else $error("ERROR selWB");
		assert(selMEMRD ==  1'b0) $display("selMEMRD Correcto"); else $error("ERROR selMEMRD");
		assert(selMEMWR ==  1'b0) $display("selMEMWR Correcto"); else $error("ERROR selMEMWR");
		
		assert(selCACHEWR ==  1'b1) $display("selCACHEWR Correcto"); else $error("ERROR selCACHEWR");
		assert(selCACHESH ==  1'b0) $display("selCACHESH Correcto"); else $error("ERROR selCACHESH");
		assert(selBRANCH ==  1'b0) $display("selBRANCH Correcto"); else $error("ERROR  selBRANCH");
		
		
		instruction = 32'b11_10_0001_0001_0010_000000000000000_0;#100;//LDK
	   $display("LDK");
      
		assert(FUNTYPE== 2'b11) $display("FUNTYPE Correcto"); else $error("ERROR FUNTYPE");
		assert(FUNCODE== 2'b10) $display("FUNCODE Correcto"); else $error("ERROR FUNCODE");
		
		assert(selWB== 1'b1 ) $display("selWB Correcto"); else $error("ERROR selWB");
		assert(selMEMRD ==  1'b0) $display("selMEMRD Correcto"); else $error("ERROR selMEMRD");
		assert(selMEMWR ==  1'b0) $display("selMEMWR Correcto"); else $error("ERROR selMEMWR");
		
		assert(selCACHEWR ==  1'b0) $display("selCACHEWR Correcto"); else $error("ERROR selCACHEWR");
		assert(selCACHESH ==  1'b0) $display("selCACHESH Correcto"); else $error("ERROR selCACHESH");
		assert(selBRANCH ==  1'b0) $display("selBRANCH Correcto"); else $error("ERROR  selBRANCH");
		
		instruction = 32'b11_11_0001_0001_0010_000000000000000_0;#100;//SHK
	   $display("SHK");
      
		assert(FUNTYPE== 2'b11) $display("FUNTYPE Correcto"); else $error("ERROR FUNTYPE");
		assert(FUNCODE== 2'b11) $display("FUNCODE Correcto"); else $error("ERROR FUNCODE");
		
		assert(selWB== 1'b0 ) $display("selWB Correcto"); else $error("ERROR selWB");
		assert(selMEMRD ==  1'b0) $display("selMEMRD Correcto"); else $error("ERROR selMEMRD");
		assert(selMEMWR ==  1'b0) $display("selMEMWR Correcto"); else $error("ERROR selMEMWR");
		
		assert(selCACHEWR ==  1'b0) $display("selCACHEWR Correcto"); else $error("ERROR selCACHEWR");
		assert(selCACHESH ==  1'b1) $display("selCACHESH Correcto"); else $error("ERROR selCACHESH");
		assert(selBRANCH ==  1'b0) $display("selBRANCH Correcto"); else $error("ERROR  selBRANCH");
		
		
end	
			
endmodule
