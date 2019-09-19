`include "ProcessorStructs.sv" 

module Processor 
//idpl : InstructionDecodePipeLine
//depl : DecodeExecutePipeLine
#(parameter ibus = 32, rbus = 32, mbus = 32) 
	(
		input  logic clk, rst,
		input  logic [ibus-1:0] instruction,
		input  logic [mbus-1:0] loadedData,
		input  logic [mbus-1:0] pcDir,
		output logic [mbus-1:0] storeData,
		output logic [mbus-1:0] addressData,
		output logic [mbus-1:0] PCout,
		output logic MWE,MRE
	);

	logic [ibus-1:0] instructionp;
	
	logic [1:0] FUNTYPE, FUNCODE;
	logic [3:0] RopA,RopB,RDwb;
	logic [31:0] WBd, PCi;
	logic [31:0] OPA, OPB, STR_DATA, PCo, RKo;
	logic [3:0] RDo;
	logic RopAIsReg,RopBIsReg,selWB, selMEMRD, selMEMWR, selCPRS, selCACHEWR, selCACHESH, selBRANCH,WE;

	logic [23:0] cacheDeco [0:2];
	logic [23:0] cacheMem [0:2];

	logic [rbus-1:0]  result, operandB;
	logic [3:0] CPSR;

	
	logic [23:0] cacheExec [0:2];

	
	
	forwardcollection _fwcollection;
	
	
	//Fetch Instruction
	
	Pipeline #(ibus) _fetch_deco(clk,rst,instruction,instructionp);
	

	//Decoding instruction
	
	InstructionDecoder #(rbus) _decoder(instructionp, WBd, PCi,RDwb,WE, clk, CPSR, OPA, OPB, STR_DATA, PCo, RKo, RopA,RopB,RDo,RopAIsReg,RopBIsReg, FUNTYPE, FUNCODE, selWB, selMEMRD, selMEMWR, selCACHEWR, selCACHESH, selBRANCH,_fwcollection);
	
	assign PCi = pcDir;
	assign PCout = PCo;

	idpipe _idpipe,_idpipeo;	
	assign _idpipe.OPA = OPA;
	assign _idpipe.OPB = OPB;
	assign _idpipe.STR_DATA = STR_DATA;
	assign _idpipe.RDo = RDo;
	assign _idpipe.RopA = RopA;
	assign _idpipe.RopB = RopB;
	assign _idpipe.RopAIsReg = RopAIsReg;
	assign _idpipe.RopBIsReg = RopBIsReg;
	assign _idpipe.RKo = RKo;
	assign _idpipe.FUNTYPE = FUNTYPE;
	assign _idpipe.FUNCODE = FUNCODE;
	assign _idpipe.selWB = selWB;
	assign _idpipe.selMEMRD = selMEMRD;
	assign _idpipe.selMEMWR = selMEMWR;
	assign _idpipe.selCACHEWR = selCACHEWR;
	assign _idpipe.selCACHESH = selCACHESH;
	assign _idpipe.selBRANCH = selBRANCH;
	assign _idpipe.CacheA = cacheDeco[0];
	assign _idpipe.CacheB = cacheDeco[1];
	assign _idpipe.CacheC = cacheDeco[2];
	
	
	//si no se entiende el diagrama documentar estas lineas
	assign cacheDeco[0] = cacheMem[0];
	assign cacheDeco[1] = cacheMem[1];
	assign cacheDeco[2] = cacheMem[2];
	

	//Decoding Execution pipeline
	
	DecoExecPipeline _deco(clk,rst,_idpipe, _idpipeo);
	
	
	//Execution

	
	assign cacheExec[0] = _idpipeo.CacheA;
	assign cacheExec[1] = _idpipeo.CacheB;
	assign cacheExec[2] = _idpipeo.CacheC;
	
	logic [rbus-1:0] OpAFwExe,OpBFwExe;
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
	
	ALU #(rbus) _alu (
		OpAFwExe, OpBFwExe,
		//_idpipeo.OPA,_idpipeo.OPB,
		_idpipeo.RKo[1:0], 
		cacheExec, 
		_idpipeo.FUNTYPE, 
		_idpipeo.FUNCODE, 
		result, 
		CPSR,
		operandB
	);

	
	

	ForwardUnitCell #(rbus) _fw_exec(_fwcollection.memphase, _idpipeo.RopA,_idpipeo.RopB,
	_idpipeo.OPA,_idpipeo.OPB,	OpAFwExe,OpBFwExe);
	
	
	assign _fwcollection.exephase.RD = _idpipeo.RDo;
	assign _fwcollection.exephase.forwardData = result;
	assign _fwcollection.exephase.selWB = _idpipeo.selWB;
	
	execpipe _execpipe,_execpipeo;
	
	assign _execpipe.ExecResult = result;
	assign _execpipe.STR_DATA = _idpipeo.STR_DATA ;
	assign _execpipe.RKo = _idpipeo.RKo ;
	assign _execpipe.RDo = _idpipeo.RDo ;
	assign _execpipe.selWB = _idpipeo.selWB ;
	assign _execpipe.selMEMRD = _idpipeo.selMEMRD ;
	assign _execpipe.selMEMWR = _idpipeo.selMEMWR ;
	assign _execpipe.selCACHEWR = _idpipeo.selCACHEWR ;
	assign _execpipe.selCACHESH = _idpipeo.selCACHESH ;
	assign _execpipe.selBRANCH = _idpipeo.selBRANCH ;
	assign _execpipe.operandB = operandB ;
	

	//Execution Memory Pipeline
	
	ExecMemPipeline _exec_mem(clk,rst,_execpipe, _execpipeo);

	//Memory
	
	assign addressData = _execpipeo.ExecResult;
	assign storeData = _execpipeo.STR_DATA;
	assign MWE = _execpipeo.selMEMWR;
	assign MRE = _execpipeo.selMEMRD;
	
		
	//Revisar direccion del cache como operandB
	CacheColor _cache(
		_execpipeo.selCACHESH,clk,rst,_execpipeo.selCACHEWR,_execpipeo.STR_DATA,
		_execpipeo.operandB,cacheMem
	);
	
	
	//Memory Writeback Pipeline
	
	mempipe _mempipe;
	mempipe _mempipeo;

	assign _mempipe.ExecResult = _execpipeo.ExecResult;
	assign _mempipe.RDo = _execpipeo.RDo ;
	assign _mempipe.selWB = _execpipeo.selWB ;
	assign _mempipe.selMEMRD = _execpipeo.selMEMRD ;
	assign _mempipe.loadedData = loadedData ;
	assign _mempipe.selBRANCH = _execpipeo.selBRANCH ;
	assign _mempipe.operandB = _execpipeo.operandB ;
	
	
	
	
	assign _fwcollection.memphase.RD = _execpipeo.RDo;
	assign _fwcollection.memphase.forwardData = (_execpipeo.selMEMRD)?_mempipe.loadedData:_execpipeo.ExecResult;
	assign _fwcollection.memphase.selWB = _execpipeo.selWB;
	
	
	
	
	
	MemWriteBackPipeline _mem_wb(clk,rst,_mempipe, _mempipeo);
	
	
	
	
	assign _fwcollection.wbphase.RD = _mempipeo.RDo;
	assign _fwcollection.wbphase.forwardData = WBd;
	assign _fwcollection.wbphase.selWB = _mempipeo.selWB;
	
	
	
	//Writeback
	
	//si no se entiende el diagrama documentar estas lineas
	assign WBd = (_mempipeo.selMEMRD)?_mempipeo.loadedData:_mempipeo.ExecResult;
	assign WE = _mempipeo.selWB;
	assign RDwb = _mempipeo.RDo;
	
	
	
endmodule

