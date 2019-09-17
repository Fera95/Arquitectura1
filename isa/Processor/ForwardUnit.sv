`include "ProcessorStructs.sv" 

module ForwardUnit #(parameter rbus = 32)
	(
	input  forwardcollection _fw, 
	input  logic [3:0] RS,RX,
	input  logic [rbus-1:0] RSdata,RXdata,	
	output logic [rbus-1:0] OpAFw,OpBFw
	);
	
	logic [rbus-1:0] OpAFwWrb,OpBFwWrb,OpAFwMem,OpBFwMem;

	ForwardUnitCell #(rbus) _fwwrb(_fw.wbphase , RS,RX,RSdata,RXdata,OpAFwWrb,OpBFwWrb);
	ForwardUnitCell #(rbus) _fwmem(_fw.memphase, RS,RX,OpAFwWrb,OpBFwWrb,OpAFwMem,OpBFwMem);
	ForwardUnitCell #(rbus) _fwexe(_fw.exephase, RS,RX,OpAFwMem,OpBFwMem,OpAFw,OpBFw);	
	


endmodule

