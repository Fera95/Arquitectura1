module DataMemory
#(parameter filename = "zelda.hex")
(
	input logic clk,
	input logic enable,
	input logic write_enable,
	input logic read_enable,
	input logic [13:0] address,
	input logic [31:0]input_data,
	output logic [31:0] output_data
);
	logic [31:0] memory [0:15];
	
	/*Se inicializan las memorias (solo la primer vez) */
	initial begin
        $readmemb(filename, memory);
    end

	always_ff @(posedge clk) begin
		
		if (enable)
		begin
		
			if (read_enable)
			begin
				output_data <= memory[address];
			end
			else if (write_enable)
				begin
					memory[address] <= input_data;
				end
		
		end
	
	end
	
	
endmodule
