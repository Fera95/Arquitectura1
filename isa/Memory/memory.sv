/*
255 data 		-> 8 data bits 

640*480 data 	-> 19 address bits

640*480*8 = 2.4 Mb <-> 307 kB
*/

module memory (input logic clk, WriteEnable,
					input logic [31:0] Address, 
					input logic [7:0] WriteData,
				  output logic [7:0] ReadData);

	logic [15:0] dataline [524288:0]; //2ˆ19 16bit lines
					
	initial begin
		$readmemh("B:\\(D)\\Documentos\\Quartus II Projects\\memoryModule\\RAM.mem",dataline); //update to not include whole path
	end
	
	always_ff @(posedge clk)
	
		if(WriteEnable)
			dataline[Address[31:0]] <= WriteData;
		
	
	
	always_ff @(negedge clk)
		ReadData <= dataline[Address[31:0]];
		
			
			
endmodule
