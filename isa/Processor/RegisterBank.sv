/*
This module describes a register bank of 14 32-bit general purpose registers, 1 32-bit kernel register and 1 32-bit PC register.
*/

module RegisterBank #(parameter bus = 32, dir = 4, reg_num = 2**dir) 
	(
		input logic[dir-1:0] RD,RS,RX,RK, input logic[bus-1:0] WB,PCi, //RD value is WB 
		input logic clk,WE,RE, output logic [bus-1:0] RSd,RXd,RKd,PCo);

	logic [bus-1:0] registerBank [0:reg_num-1];

	initial begin
		$readmemb("regBnk.txt",registerBank);
	end
	
	//always_ff is not used because the book recomends not to use flip-flops
	//SRAMs are more compact than flipflops
	always @(posedge clk) begin
		// Use RE to indicate a valid RD is on the 
		//line and read the memory into a register at that RD 
		// when RE is asserted
		PCo <= registerBank[15];
		if (RE == 1'b1) begin
			RSd <= registerBank[RS];
			RXd <= registerBank[RX];
			RKd <= registerBank[RK];
		end
	end
	
	
	always @(negedge clk) begin
		registerBank[15] <= PCi;
		if (WE == 1'b1) begin
			registerBank[RD] <= WB;
		end
	end

endmodule
