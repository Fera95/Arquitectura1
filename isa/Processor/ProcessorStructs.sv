`ifndef _Processor_Structs_
`define _Processor_Structs_


localparam rbus = 32;
localparam mbus = 32;
typedef struct packed{
	logic [23:0] CacheA;
	logic [23:0] CacheB;
	logic [23:0] CacheC;
	logic [rbus-1:0] OPA;
	logic [rbus-1:0] OPB;
	logic [rbus-1:0] STR_DATA;
	logic [rbus-1:0] RKo;
	logic [3:0] RopA;
	logic [3:0] RopB;
	logic RopAIsReg;
	logic RopBIsReg;
	logic [3:0] RDo;
	logic [1:0] FUNTYPE;
	logic [1:0] FUNCODE;
	logic selWB;
	logic selMEMRD;
	logic selMEMWR;
	logic selCACHEWR;
	logic selCACHESH;
	logic selBRANCH;

}idpipe;


typedef struct packed{
	logic [rbus-1:0] ExecResult;
	logic [rbus-1:0] operandB;
	logic [rbus-1:0] STR_DATA;
	logic [rbus-1:0] RKo;
	logic [3:0] RDo;
	logic selWB;
	logic selMEMRD;
	logic selMEMWR;
	logic selCACHEWR;
	logic selCACHESH;
	logic selBRANCH;

}execpipe;



typedef struct packed{
	logic [rbus-1:0] ExecResult;
	logic [rbus-1:0] operandB;
	logic [3:0] RDo;
	logic selWB;
	logic selMEMRD;
	logic selBRANCH;
	logic [mbus-1:0] loadedData;
}mempipe;





typedef struct packed{
	logic selWB;
	logic [3:0] RD;
	logic [rbus-1:0] forwardData;

}forwardphase;



typedef struct packed{
	forwardphase  wbphase;
	forwardphase memphase;
	forwardphase exephase;
}forwardcollection;

`endif