module VGA (input logic clk,
				output logic hsync_out, vsync_out, sync_b_out, blank_b_out,clk_out,
				output logic [7:0] red,green,blue);

	//Frequency devider
	 logic reset;
	 assign reset = 0;
	 FREQ_DIVIDER freq_divider(clk, reset,clk_out);
	 
	 
	 //VGA_CONTROLLER input logic vgaclk, reset,
    //output logic hsync, vsync, sync_b, blank_b,
    //output logic [9:0] hcnt, vcnt
	
	 logic [9:0] hcnt_out, vcnt_out;
	 VGA_CONTROLLER vga_controller( clk_out, reset, hsync_out, vsync_out, sync_b_out, blank_b_out, hcnt_out, vcnt_out);
	 
	 	 //Set the color
		 
	 always @ *
		if (0 <= vcnt_out & vcnt_out < 192 ) begin 
		//DAE8FC
			 red = 8'hCE;
			 green = 8'h00;
			 blue = 8'h30;
		end
	
		
	
	 	 
	 
endmodule
