module InstructionDecoder_tb ();


			logic [31:0] instruction;
			logic [1:0] FUNTYPE, FUNCODE;
			logic [3:0] RDwb;
			logic WE, clk;
			logic [31:0] WBd, PCi;
			logic [31:0] OPA, OPB, STR_DATA, PCo, RKo;
			logic [3:0] RDo;
			logic selWB, selMEMRD, selMEMWR, selCPRS, selCACHEWR, selCACHESH, selBRANCH;
			
			
			
			InstructionDecoder #(32) _DUT (instruction, WBd, PCi,RDwb,WE, clk, OPA, OPB, STR_DATA, PCo, RKo, RDo, FUNTYPE, FUNCODE, selWB, selMEMRD, selMEMWR, selCACHEWR, selCACHESH, selBRANCH);
			initial begin
			
				instruction = 32'b00100001000100110000000000000000; //suma
				clk = 1;
				RDwb = 4'b1000; //r8
				WBd = 32'b0000000000000000000000000000000011;
				PCi = 32'b0000000000000000000000000000001100;
				WE = 1'b1;
				
				#500 
				
				clk = 0;
				
				#500 
				
				clk = 1;
								
			
			end
			
endmodule