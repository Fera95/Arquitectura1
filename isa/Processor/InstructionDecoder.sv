/*
This module implements the instruction decoder which takes a 32 bits instruction and returns its decoded function type and code, its registers addresses and 
its extended immediate as well as its immediate signal
*/

module InstructionDecoder #(parameter bus = 32) (
			input logic [31:0] instruction,  
			input logic [bus-1:0] WBd, PCi,
			input logic [3:0] RDwb,
			input logic WE, clk,
			output logic [bus-1:0] OPA, OPB, STR_DATA, PCo, RKo, 
			output logic [3:0] RDo, 
			output logic [1:0] FUNTYPE, FUNCODE,
			output logic selWB, selMEMRD, selMEMWR, selCACHEWR, selCACHESH, selBRANCH);

	//Variables declaration for segments of the instruction
	logic [3:0] RSt, RS, RX;
	logic [bus-1:0] Imm4, Imm19, Imm28, Imm, OPAt, OPBt;
	
	//Assign the bit set to its variables
	assign FUNTYPE  = instruction[31:30];
	assign FUNCODE  = instruction[29:28];
	assign RDo = instruction[27:24];
	assign RSt = instruction[23:20];
	assign RX = instruction[19:16];
	assign selimm = instruction[0];
	assign Imm4[3:0] = instruction[23:20];	
	assign Imm19[18:0] = instruction[19:1];
	assign Imm28[27:0] = instruction[27:0];
	assign Imm4[bus-1:4] = '0;
	assign Imm28[bus-1:28] = '0;
	assign Imm19[bus-1:19] = '0;	
	
	//intermediate flags: funtype
	logic isReg, isMem, isBranch, isKernel;
	assign isReg = ~FUNTYPE[1] && ~FUNTYPE[0]; //00
	assign isMem = ~FUNTYPE[1] && FUNTYPE[0];  //01
	assign isBranch = FUNTYPE[1] && ~FUNTYPE[0]; //10
	assign isKernel = FUNTYPE[1] && FUNTYPE[0]; //11
	
	//intermediate flags: WB flag per funtype
	
	logic regWB, kerWB,  memWB;

	assign regWB = isReg && (~FUNCODE[1] || ~FUNCODE[0]);  //only when is not CMP
	assign memWB = isMem && ~FUNCODE[1] && ~FUNCODE[0];
	assign kerWB = isKernel && ~FUNCODE[0];	
	//Branch: isBranch always activates WB to write on PC
		
	//setting up the output flags
	assign selWB = regWB || memWB || isBranch || kerWB;
	assign selMEMRD = isMem && ~FUNCODE[1] && ~FUNCODE[0];
	assign selMEMWR = isMem && ~FUNCODE[1] && FUNCODE[0];
	assign selCPRS = isReg && FUNCODE[1] && FUNCODE[0];
	assign selCACHEWR = isKernel && ~ FUNCODE[1] && FUNCODE[0];
	assign selCACHESH = isKernel && ~ FUNCODE[1] && FUNCODE[1];
	assign selBRANCH = isBranch;
	
	//CMP distinc behavior: RD value is copied into RS in order to get the proper OPA and OPB for the comparison as the comparison is RD == RS and RD == Imm
	assign RS = regWB?RSt:RDo;
	
	//Select the right Imm extended to return according to the function
	logic [bus-1:0] immTmp;
	assign immTmp=isReg?Imm19:Imm28;
	assign Imm=isBranch?immTmp:Imm4;
	
	logic [bus-1:0] pcOut;
	
	RegisterBank #(32, 4, 16) _regbank(RDwb,RS,RX,4'b1110, WBd, PCi, clk,WE,1'b1, STR_DATA, OPAt,OPBt,RKo,pcOut);
	
	
	//flags for correct operand assignment
	
	logic isMov, isZero;
	assign isMov = isReg && FUNCODE[1] && ~FUNCODE[0];
	assign isZero = isMov || isKernel;
	
	assign OPA = isZero?'0:OPAt;
	
	assign OPB = selimm?Imm:OPBt;
		
		
		
	BranchUnit #(bus,bus) _branchUnit(PCi,OPB,selBRANCH,PCo);
	
	
endmodule