module demux_2 #(parameter N=8) (
	input [N-1:0] data_in, 
	input  selection_i, 
	output [N-1:0] result1,result2);
	
	
	
	always @(selection_i or data_in)
	
	
	begin
        case (selection_i)  
            1'b0 : begin
                        result1 = data_in;
                        result2 = 0;
                       
                      end
            1'b1 : begin
                        result1 = 0;
                        result2 = data_in;
                      end
            default : begin
								result1 = 0;
                        result2 = 0;
                      end
          
        endcase
    end
	 
endmodule
