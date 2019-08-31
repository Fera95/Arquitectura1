module VGA (input logic clk,
				input logic [11:0] tiles,
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
			 red = 8'hDA;
			 green = 8'hE8;
			 blue = 8'hFC;
		end
		
	/*
		else if (vcnt_out >= 192 & ( (hcnt_out == 0)    | 
				                       (hcnt_out == 90)   | 
											  (hcnt_out == 180)  | 
											  (hcnt_out == 270)  | 
											  (hcnt_out == 360)  | 
											  (hcnt_out == 450)  | 
											  (hcnt_out == 540)  | 
											  (hcnt_out == 640)  )) begin 
			 red = 8'b0000_0000;
			 green = 8'b0000_0000;
			 blue = 8'b0000_0000;
		
		end
		
		else if (( 192 <= vcnt_out & vcnt_out <= 400) & (   (  65 <= hcnt_out  & hcnt_out <= 115)  | 
																			 (  155 < hcnt_out  & hcnt_out <= 205) | 
																			 (  245 <= hcnt_out  & hcnt_out <= 295)   | 
																			 (  425 <= hcnt_out  & hcnt_out <= 475)   |  
																			 (  515 <= hcnt_out  & hcnt_out <= 565) )) begin 
			 
			 /*if( (  65 <= hcnt_out  & hcnt_out <= 115) & tiles[1] == 0)begin
					red = 8'b0000_0000;
					green = 8'b1111_1111;
					blue = 8'b0000_0000;
			 
			 end
			 else if ((  155 <= hcnt_out  & hcnt_out <= 205) & tiles[3] == 0)begin
					red = 8'b0000_0000;
					green = 8'b1111_1111;
					blue = 8'b0000_0000;
			 
			 end
			 else if ((245 <= hcnt_out  & hcnt_out <= 295) & tiles[5] == 0)begin
				   red = 8'b0000_0000;
					green = 8'b1111_1111;
					blue = 8'b0000_0000;
			 
			 end
			 
			 else if ((425 <= hcnt_out  & hcnt_out <= 475) & tiles[8] == 0)begin
					red = 8'b0000_0000;
					green = 8'b1111_1111;
					blue = 8'b0000_0000;
			 
			 end
			 
			 else if ((515 <= hcnt_out  & hcnt_out <= 565) & tiles[10] == 0)begin
					red = 8'b0000_0000;
					green = 8'b1111_1111;
					blue = 8'b0000_0000;
			 
			 end
			 
			 else begin
				red = 8'b0000_0000;
				green = 8'b0000_0000;
				blue = 8'b0000_0000;
			 end
			 
		
		end*/
		
		
		//Bordes negros
		else if (192 == vcnt_out)begin
											
			red = 8'b0000_0000;
			green = 8'b0000_0000;
			blue = 8'b0000_0000;		
		end
		
		else if (192 <= vcnt_out & hcnt_out == 0)   begin 
			red = 8'b0000_0000;
			green = 8'b0000_0000;
			blue = 8'b0000_0000;		
		end
		else if (400 <= vcnt_out & hcnt_out == 90)  begin 
			red = 8'b0000_0000;
			green = 8'b0000_0000;
			blue = 8'b0000_0000;		
		end	
		else if (400 <= vcnt_out & hcnt_out == 180) begin 
			red = 8'b0000_0000;
			green = 8'b0000_0000;
			blue = 8'b0000_0000;		
		end
		else if (400 <= vcnt_out & hcnt_out == 270) begin 
			red = 8'b0000_0000;
			green = 8'b0000_0000;
			blue = 8'b0000_0000;		
		end
		else if (192 <= vcnt_out & hcnt_out == 360) begin 
			red = 8'b0000_0000;
			green = 8'b0000_0000;
			blue = 8'b0000_0000;		
		end
		else if (400 <= vcnt_out & hcnt_out == 450) begin 
			red = 8'b0000_0000;
			green = 8'b0000_0000;
			blue = 8'b0000_0000;		
		end
		else if (400 <= vcnt_out & hcnt_out == 540) begin 
			red = 8'b0000_0000;
			green = 8'b0000_0000;
			blue = 8'b0000_0000;		
		end
	   else if (192 <= vcnt_out & hcnt_out == 639) begin 
			red = 8'b0000_0000;
			green = 8'b0000_0000;
			blue = 8'b0000_0000;		
		end
		
		
		//Tile 0
		else if ( (193 <= vcnt_out & vcnt_out <= 479  & 0 <= hcnt_out &  hcnt_out <= 64 )  |  
		          (401 <= vcnt_out & vcnt_out <= 479  & 0 <= hcnt_out &  hcnt_out <= 89 ) )begin
		
			if(tiles[0] == 0)begin
				red = 8'b0000_0000;
				green = 8'b1111_1111;
				blue = 8'b0000_0000;
			end
			
			else begin
				red = 8'b1111_1111;
				green = 8'b1111_1111;
				blue = 8'b1111_1111;			
			end
											
		end
		
		//Tile 1
		else if (193 <= vcnt_out & vcnt_out <= 400  & 65 <= hcnt_out  & hcnt_out <= 115 )begin
		
			if(tiles[1] == 0)begin
				red = 8'b0000_0000;
				green = 8'b1111_1111;
				blue = 8'b0000_0000;
			end
			
			else begin
				red = 8'b0000_0000;
				green = 8'b0000_0000;
				blue = 8'b0000_0000;			
			end
											
		end
		
		
		//Tile 2
		else if ( (193 <= vcnt_out & vcnt_out <= 400  & 116 <= hcnt_out &  hcnt_out <= 154 )  |  
		          (401 <= vcnt_out & vcnt_out <= 479  & 91 <= hcnt_out &  hcnt_out <= 179 ) )begin
		
			if(tiles[2] == 0)begin
				red = 8'b0000_0000;
				green = 8'b1111_1111;
				blue = 8'b0000_0000;
			end
			
			else begin
				red = 8'b1111_1111;
				green = 8'b1111_1111;
				blue = 8'b1111_1111;			
			end
											
		end
		
		//Tile 3
		else if (193 <= vcnt_out & vcnt_out <= 400  & 155 <= hcnt_out  & hcnt_out <= 205 )begin
		
			if(tiles[3] == 0)begin
				red = 8'b0000_0000;
				green = 8'b1111_1111;
				blue = 8'b0000_0000;
			end
			
			else begin
				red = 8'b0000_0000;
				green = 8'b0000_0000;
				blue = 8'b0000_0000;			
			end
											
		end
		
		
		//Tile 4
		else if ( (193 <= vcnt_out & vcnt_out <= 400  & 206 <= hcnt_out &  hcnt_out <= 244 )  |  
		          (401 <= vcnt_out & vcnt_out <= 479  & 181 <= hcnt_out &  hcnt_out <= 269 ) )begin
		
			if(tiles[4] == 0)begin
				red = 8'b0000_0000;
				green = 8'b1111_1111;
				blue = 8'b0000_0000;
			end
			
			else begin
				red = 8'b1111_1111;
				green = 8'b1111_1111;
				blue = 8'b1111_1111;			
			end
											
		end
		
		//Tile 5
		else if (193 <= vcnt_out & vcnt_out <= 400  & 245 <= hcnt_out  & hcnt_out <= 295 )begin
		
			if(tiles[5] == 0)begin
				red = 8'b0000_0000;
				green = 8'b1111_1111;
				blue = 8'b0000_0000;
			end
			
			else begin
				red = 8'b0000_0000;
				green = 8'b0000_0000;
				blue = 8'b0000_0000;			
			end
											
		end
//		
		//Tile 6
		else if ( (193 <= vcnt_out & vcnt_out <= 479  & 256 <= hcnt_out &  hcnt_out <= 359 )  |  
		          (401 <= vcnt_out & vcnt_out <= 479  & 271 <= hcnt_out &  hcnt_out <= 359 ) )begin
		
			if(tiles[6] == 0)begin
				red = 8'b0000_0000;
				green = 8'b1111_1111;
				blue = 8'b0000_0000;
			end
			
			else begin
				red = 8'b1111_1111;
				green = 8'b1111_1111;
				blue = 8'b1111_1111;			
			end
											
		end
//		
		//Tile 7
		else if ( (193 <= vcnt_out & vcnt_out <= 479  & 361 <= hcnt_out &  hcnt_out <= 424 )  |  
		          (401 <= vcnt_out & vcnt_out <= 479  & 361 <= hcnt_out &  hcnt_out <= 449 ) )begin
		
			if(tiles[7] == 0)begin
				red = 8'b0000_0000;
				green = 8'b1111_1111;
				blue = 8'b0000_0000;
			end
			
			else begin
				red = 8'b1111_1111;
				green = 8'b1111_1111;
				blue = 8'b1111_1111;			
			end
											
		end
		
		//
		//Tile 8
		else if (193 <= vcnt_out & vcnt_out <= 400  & 425 <= hcnt_out  & hcnt_out <= 475 )begin
		
			if(tiles[8] == 0)begin
				red = 8'b0000_0000;
				green = 8'b1111_1111;
				blue = 8'b0000_0000;
			end
			
			else begin
				red = 8'b0000_0000;
				green = 8'b0000_0000;
				blue = 8'b0000_0000;			
			end
											
		end
		
		
		//Tile 9
		else if ( (193 <= vcnt_out & vcnt_out <= 400  & 476 <= hcnt_out &  hcnt_out <= 514 )  |  
		          (401 <= vcnt_out & vcnt_out <= 479  & 451 <= hcnt_out &  hcnt_out <= 539 ) )begin
		
			if(tiles[9] == 0)begin
				red = 8'b0000_0000;
				green = 8'b1111_1111;
				blue = 8'b0000_0000;
			end
			
			else begin
				red = 8'b1111_1111;
				green = 8'b1111_1111;
				blue = 8'b1111_1111;			
			end
											
		end
		
		
		
		//Tile 10
		else if (193 <= vcnt_out & vcnt_out <= 400  & 515 <= hcnt_out  & hcnt_out <= 565 )begin
		
			if(tiles[10] == 0)begin
				red = 8'b0000_0000;
				green = 8'b1111_1111;
				blue = 8'b0000_0000;
			end
			
			else begin
				red = 8'b0000_0000;
				green = 8'b0000_0000;
				blue = 8'b0000_0000;			
			end
											
		end
		
//		
		//Tile 11
		else if ( (193 <= vcnt_out & vcnt_out <= 479  & 566 <= hcnt_out &  hcnt_out <= 639 )  |  
		          (401 <= vcnt_out & vcnt_out <= 479  & 541 <= hcnt_out &  hcnt_out <= 639 ) )begin
		
			if(tiles[11] == 0)begin
				red = 8'b0000_0000;
				green = 8'b1111_1111;
				blue = 8'b0000_0000;
			end
			
			else begin
				red = 8'b1111_1111;
				green = 8'b1111_1111;
				blue = 8'b1111_1111;			
			end
											
		end
		
		
		
		else begin 
			 red = 8'b1111_1111;
			 green = 8'b1111_1111;
			 blue = 8'b1111_1111;
		end
	
			
	 
	
		

	 	 
	 
endmodule
