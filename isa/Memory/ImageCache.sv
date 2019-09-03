module ImageCache #(parameter bus = 24)
	(input logic clk, rst,
	 input logic [4:0] pos,
	 input logic [bus-1:0] din,
	 output logic [bus*4-4:0] dout
	); 
	
	logic [bus-1:0] memory [0:15];
	
	/**
	+ Se aplica el kernel
	+ Se llama a shift cache
	+ se aplica el kernel de nuevo
	+ se llama a shift cache
	+ se carga informacion al cache y se repite el proceso de nuevo
	
	<--------Ancho ------->
i->x x x x   x x x x x x x x
	x x x x   x x x x x x x x
	x x x x   x x x x x x x x
  	
	<--------------------------------------->
	 #1    #2
	[x x] [x x]
	 #3    #4	
	[x x] [x x]
	 #5    #6
	[x x] [x x]
	
	LDK [i],#1
	LDK [i+2],#2
	LDK [fila + i ],#3
	LDK [fila + i + 2 ],#4
	LDK [fila + i ],#5
	LDK [fila + i + 2 ],#6
	
	
	LKN @sharpen
	
	KRN R0
	
	SHK
	
	 #1    #2
	[x x] [x 0]
	 #3    #4	
	[x x] [x 0]
	 #5    #6
	[x x] [x 0]	
	
	LDR R0
	
	KRN R0
	
	SHK
	
	 #1    #2
	[x x] [0 0]
	 #3    #4	
	[x x] [0 0]
	 #5    #6
	[x x] [0 0]		
	
	LDK [i+2],#2
	LDK [fila + i + 2 ],#4
	LDK [fila' + i + 2 ],#6

	
	fila  = fila + ancho
	mov r1, ancho
	add r0,r0,r1
	
	
	*/
	
	
	
	always_ff @(posedge clk)
	begin
		
		
		
	
	end
	
	
endmodule
