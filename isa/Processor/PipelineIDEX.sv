/*

This module implements the pipeline between Decode And Execute stage. 
It writes on the pipelines register on the negative semicycle and outputs the pipelines register on the positive one.
*/

module PipelineIDEX #(parameter bus = 32) 
	(
		input logic clk,
	
		input logic [23:0] cachemem [2:0],
		input logic [bus-1:0] OPAdec, OPBdec, STR_DATAdec, PCdec, RKdec, 
		input logic [3:0] RDdec, 
		input logic [1:0] FUNTYPEdec, FUNCODEdec,
		input logic selWBdec, selMEMRDdec, selMEMWRdec, selCACHEWRdec, selCACHESHdec, selBRANCHdec,
	
		output logic [23:0] cacheexe [2:0],
		output logic [bus-1:0] OPAexe, OPBexe, STR_DATAexe, PCexe, RKexe, 
		output logic [3:0] RDexe, 
		output logic [1:0] FUNTYPEexe, FUNCODEexe,
		output logic selWBexe, selMEMRDexe, selMEMWRexe, selCACHEWRexe, selCACHESHexe, selBRANCHexe
		);
		
	logic [23:0] pipecache [2:0];
	logic [bus-1:0] pipeOPA, pipeOPB, pipeSTRDATA, pipePC, pipeRK;
   logic [3:0] pipeRD;
	logic [1:0] pipeFUNTYPE, pipeFUNCODE;
	logic pipeselWB, pipeselMEMRD, pipeselMEMWR, pipeselCACHEWR, pipeselCACHESH, pipeselBRANCH;
    initial begin
	end
    always_ff @(posedge clk) begin
		cacheexe <= pipecache;
		OPAexe <= pipeOPA;
		OPBexe <= pipeOPB ;
		STR_DATAexe <= pipeSTRDATA;
		PCexe <=  pipePC;
		RKexe <= pipeRK; 
		RDexe <= pipeRD;
		FUNTYPEexe <= pipeFUNTYPE;
		FUNCODEexe <=  pipeFUNCODE;
		selWBexe <= pipeselWB; 
		selMEMRDexe <=  pipeselMEMRD;
		selMEMWRexe <= pipeselMEMWR;
		selCACHEWRexe <= pipeselCACHEWR;
		selCACHESHexe <= pipeselCACHESH;
		selBRANCHexe <=  pipeselBRANCH;

	end
	always_ff @(negedge clk) begin
		pipecache <= cachemem;
		pipeOPA <= OPAdec;
		pipeOPB <=  OPBdec;
		pipeSTRDATA <= STR_DATAdec;
		pipePC <= PCdec;
		pipeRK <= RKdec;
		pipeRD <= RDdec;
		pipeFUNTYPE <= FUNTYPEdec;
		pipeFUNCODE <= FUNCODEdec;
		pipeselWB <= selWBdec;
		pipeselMEMRD <= selMEMRDdec;
		pipeselMEMWR <= selMEMWRdec;
		pipeselCACHEWR <=  selCACHEWRdec;
		pipeselCACHESH <=  selCACHESHdec;
		pipeselBRANCH <= selBRANCHdec;
	end

endmodule
