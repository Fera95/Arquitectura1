/*This module is for an ALU that can perform one of the following operations:
add: Addition of OPA plus OPB 
sub: Addition of OPA and OPB's Two's complement 
cmp: Substraction between OPA and OPB that set the value of Z flag to 1 if they are equal
mov: Set OPC to the value of OPB, perform via an ADD with OPA set to 0 from a previous stage
*/
module ALU #(parameter bus = 4) (input logic [bus-1:0] OPA, OPB, input logic [3:0] kernelReG, input logic [15:0] cache, input logic [1:0] FUNTYPE, FUNCODE, output logic [bus-1:0] result,output logic [3:0] CPSR, output logic [bus-1:0] operandB);
    //variable inits
    logic [bus-1:0] OPC, complement2;//, operandB;  //registers for the Adder
    logic carryOut, selsub, selcmp, selc2, iszero; //signals for the Adder
		
	 logic [bus-1:0] KernelUnitResult; //registers for Kernel

	 
    //varible assignments for adder
    assign selsub = ~FUNCODE[1] && FUNCODE[0]; //01
    assign selcmp = FUNCODE[1] && ~FUNCODE[0]; //10
    assign selc2 = selsub | selcmp; //two´s complement if it a substraction or comparation
    assign operandB = selc2?complement2:OPB; 

    //Complement 2 and Adder (for add, mov, sub, cmp)
    Complement2 #(bus) _complement2(OPB, complement2);
    Adder #(bus) _add(OPA, operandB, 1'b0, OPC, carryOut, CPSR[0]);
	
	//execution decoder component that returns the input for the selector
	 logic executiondecoder;
	 assign executiondecoder = FUNTYPE[1] & FUNTYPE[0]; 
	
	//Selector between Add and Kernel functions
	Mux2 #(bus) _selector (OPC, KernelUnitResult, executiondecoder, result);
	
	
	//PLACEHOLDER: ERASE ONCE KERNEL UNIT IS COMPLETED
	assign KernelUnitResult = '0;
	
	
endmodule



