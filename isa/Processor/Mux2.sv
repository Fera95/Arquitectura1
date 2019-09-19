/*
This modules implements a mux that receives  two data signals, an input selector and outputs the signal that was selected 
*/

module Mux2 #(parameter bus = 32) (input logic [bus-1:0] d1,d2,input logic selin,output logic [bus-1:0] selout);

	assign selout = selin? d2:d1;
	
endmodule
