//This module receives two operands of N bits and it returns their addition. It also recieves an input carry and returns the proper output carry.

module Adder #(bus_size = 4) (input logic[bus_size-1:0] OPA,OPB,input logic carryIn, output logic[bus_size-1:0] result,output logic carryOut, zero);
	
	logic[bus_size:0] cout;
	assign cout[0]  = carryIn;
	assign carryOut = cout[bus_size];
	genvar i;
	generate 
		for (i = 0; i < bus_size; i = i+1) begin:forloop
			BitAdder addr(OPA[i],OPB[i],cout[i], result[i],cout[i+1]);
		end
	always_comb begin
		zero = result == '0;
	end
		
	endgenerate
	
endmodule