module ImageMemory_tb();



//instanciate modules
/*

module ImageMemory
#(parameter filename = "zelda16b.hex")
(
	input logic clk,
	input logic enable,
	input logic write_enable,
	input logic read_enable,
	input logic [13:0] address,
	input logic [15:0]input_data,
	output logic [15:0] output_data
);


*/

/*señales */

logic clk;
logic [14:0] address;
logic [15:0] input_data;
logic [15:0] output_data;
logic enable = 1;
logic write_enable = 0;
logic read_enable  = 1;
	
	


ImageMemory dut(clk,enable,write_enable,read_enable, address,input_data,output_data);


initial begin
   clk = 1;
//	a=4'b0000; b=4'b0000; c_in=0; #10;
//	assert(sum===4'b0000 && c_out===0 ) $display ("0000 ok"); else $error("0000 failed");



end

endmodule