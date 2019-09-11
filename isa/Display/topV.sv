module topV( input logic clk, rst,seleccion,
				
				output logic[7:0] r, g, b,
				output logic o_hs, o_vs, o_sync, o_blank, o_clk);
				
				
/*
Señales de control para leer la memoria

*/

logic enable;
logic write_enable;
logic read_enable;

/*señales de address necesarias en ambos*/
logic [14:0] address;



logic [15:0] input_data;
logic [15:0] output_data;
	
	
assign enable = 1;
assign write_enable = 0;
assign read_enable  = 1;
	
	
/*
Se instancia la memoria 
module Memory
(
	input logic clk,
	input logic enable,
	input logic write_enable,
	input logic read_enable,
	input logic [14:0] address,
	input logic [15:0]input_data,
	output logic [15:0] output_data
);



*/	

always_ff @(posedge o_clk)
	begin
		address[14] <= seleccion;
	end


Memory _mem (clk, enable, write_enable, read_enable, address, input_data, output_data);

	
/*
Se instancia el painter

	(
    input logic clk, rst
	 
	 input logic [15:0] memory_data,
	 input logic [20:0] address_in, 

    output logic[7:0] r, g, b,
	 output logic o_hs, o_vs, o_sync, o_blank, o_clk,
	 output logic [20:0] address_out);
	 
*/	

/*


*/



painter _paint(clk,rst,output_data,address[13:0],r,g,b, o_hs, o_vs, o_sync, o_blank, o_clk,address[13:0]);
	

endmodule
