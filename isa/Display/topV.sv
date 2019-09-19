module topV( input logic clk, rst,seleccion,selVGA,
				 
				output logic[7:0] r, g, b,
				output logic o_hs, o_vs, o_sync, o_blank, o_clk);
				
				


	logic enable;
	logic [31:0] address;
	logic [31:0] input_data;
	logic [31:0] output_data;
	assign enable = 1;
	logic WE;
	logic RE;

	
	
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

	
	
	logic [31:0] instruction,instructionwr;
	
	logic [31:0] pcDir;
	logic [31:0] storeData;
	logic [31:0] PCout;

	logic [31:0] addressvgain,addressvgaout,address_mem;

	logic [31:0] addressproc;
	
	logic [31:0] datainproc,dataoutproc;
	
	logic [31:0] datainvga,dataoutvga;
	
	
	DataMemory #("color.vga.o") _datamem(clk,1,0,1,PCout,instructionwr,instruction);
	
	
	Processor#(32,32,32) _proc(clk, rst,instruction,output_data,PCout,datainproc,addressproc,pcDir,WE,RE);
	
	
	
	Memory _img(clk, enable, WE, RE, address_mem[14:0], input_data[15:0], output_data[15:0]);
	
	
	Mux2 #(32) muxer_dir(addressvgaout,addressproc, selVGA,address_mem);
	
	Mux2 #(32) muxer_dat_in(datainvga,datainproc, selVGA,input_data);
	
	painter _paint(clk,rst,output_data,addressvgain[13:0],r,g,b, o_hs, o_vs, o_sync, o_blank, o_clk,addressvgaout[13:0]);


	always_ff @(posedge o_clk)
	begin
		addressvgaout[14] <= seleccion;
		
	end


	
	always_ff @(negedge clk)
	begin
		
		if (rst) begin
			PCout <= 32'd0;
		end
		else
			PCout <= pcDir;
		
	end

	

endmodule
