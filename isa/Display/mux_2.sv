module mux_2 #(parameter N=8) (
	input [N-1:0] a, b, 
	input  selection_i, 
	output [N-1:0] result);
	
	logic [N-1:0] y_o;
	always_comb
	case(selection_i)
		1'b0:   y_o = a ;
		1'b1:   y_o = b ;
		
		
		default: y_o = 8'bz;
	endcase
	
	assign result = y_o;
	 
endmodule
