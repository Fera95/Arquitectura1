//This module takes two 1 bit input operands and an input carry and returns the operands addition and an ouput carry.

module BitAdder (input logic OPA,OPB, carryIn, output logic result,carryOut);

	assign result = (OPA ^ OPB)^carryIn;
	assign carryOut = (OPA&OPB) | (carryIn & (OPA ^ OPB));

endmodule