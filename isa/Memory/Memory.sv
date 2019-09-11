module Memory
#(parameter filename = "zelda.hex", parameter filename2= "standopawa4.hex" )
(
	input logic clk,
	input logic enable,
	input logic write_enable,
	input logic read_enable,
	input logic [14:0] address,
	input logic [15:0]input_data,
	output logic [15:0] output_data
);
	
	logic [15:0] output_data1;
	logic [15:0] output_data2;
	
	//Se crea nuevo address
	logic [13:0] imaddress;
	assign imaddress = address[13:0];
	
	logic write_im_1,write_im_2; 
	
	assign write_im_1 = write_enable &  address[14];
	assign write_im_2 = write_enable & ~address[14];
	
	mux_2 #16 multiplexor(output_data1,output_data2,address[14],output_data);
	
	ImageMemory
		#( filename2)
		_im1(clk,enable,write_im_1,read_enable,imaddress,input_data,output_data1);
	ImageMemory
		#( filename)
		_im2(clk,enable,write_im_2,read_enable,imaddress,input_data,output_data2);
	
endmodule
