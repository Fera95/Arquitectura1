module not_A #(parameter N)
				(input logic [N-1:0] a,
			    output logic [N-1:0] s);
	assign s = ~a;
endmodule