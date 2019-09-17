`include "ProcessorStructs.sv" 

module ForwardUnitCell #(parameter rbus = 32)
	(
	input  forwardphase _fw, 
	input  logic [3:0] RS,RX,
	input  logic [rbus-1:0] RSdata,RXdata,	
	output logic [rbus-1:0] OpAFw,OpBFw
	);
	
	assign OpAFw = (_fw.RD == RS && _fw.selWB)? _fw.forwardData:RSdata;
	assign OpBFw = (_fw.RD == RX && _fw.selWB)? _fw.forwardData:RXdata;	
	
endmodule


