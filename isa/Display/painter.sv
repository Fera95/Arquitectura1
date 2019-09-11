/*
Módulo encargado de recibir la memoria y de pintar el valor dependiendo de 
una bandera selección
*/


module painter 

	#(parameter HACTIVE = 10'd640,
											HFP 	  = 10'd15,
											HSYN    = 10'd95,
											HBP     = 10'd48,
											HSS     = HSYN + HBP,
											HSSX    = HSYN + HBP + 10'd256,
											HSE     = HSYN + HBP + HACTIVE,
											HMAX    = HSYN + HBP + HACTIVE + HFP,
											
											VACTIVE = 10'd480,
											VFP     = 10'd10,
											VSYN    = 10'd2,
											VBP     = 10'd33,
											VSS     = VSYN + VBP,
											VSSX    = VSYN + VBP + 10'd256,
											VSE     = VSYN + VBP + VACTIVE,
											VMAX    = VSYN + VBP + VACTIVE + VFP
	)
	(
    input logic clk, rst,
	 
	 /*Señales provenientes de la memoria*/
	 input logic [15:0] memory_data,
	 input logic [13:0] address_in, 
	 
	 /*Señales de salida*/
    output logic[7:0] r, g, b,
	 output logic o_hs, o_vs, o_sync, o_blank, o_clk,
	 output logic [13:0] address_out);
	 
	logic [9:0] x, y; 
	logic counter = 0;
	logic o_rst = 1;
	logic o_clk_2;	
	logic o_clk_3;
	
	always @(posedge o_clk)
		begin 
			if (counter == 0) begin
				o_rst <= 1;
				counter <= 1;
			end
			else o_rst <= rst;
		end
	
	 frequencyDivider ffd(clk, rst, o_clk);
	 frequencyDivider ffd2(o_clk, rst, o_clk_2);
	 vgaController v0(o_clk, o_rst, o_hs, o_vs, o_sync, o_blank, x, y);
	 
	 
	logic hRstF, vRstF, hDS, hDE, vDS, vDE,hDE256, vDE256, vDE256E= 0;
	//	Blank Comparator
	comparator#(10) hDisplayStartComparator(.a(x), .b(HSS), .gte(hDS));
	comparator#(10) hDisplayStartComparator2(.a(x), .b(HSSX), .lt(hDE256));
	comparator#(10) hDisplayStartComparatorEq(.a(x), .b(HSSX), .eq(hDE256E));
	comparator#(10) hDisplayEndComparator(.a(x), .b(HSE), .lt(hDE));
	
	comparator#(10) vDisplayStartComparator(.a(y), .b(VSS), .gte(vDS));
	comparator#(10) vDisplayStartComparator2(.a(y), .b(VSSX), .lt(vDE256));
	comparator#(10) vDisplayEndComparator(.a(y), .b(VSE), .lt(vDE));
	
	
	logic [9:0] hcnt_x, vcnt_x;
	logic [2:0] flag_row = 2'b0;
	logic flag_row_fix = 0;
	logic [3:0] flag_col = 4'd0;
	logic [3:0] count8 = 4'd0;
	logic [13:0] address =0;
	
	
	/*se pinta el dato recuperado*/
	
	logic [2:0] div;
	
	
	
	
	always_ff @(posedge clk, posedge rst) begin
		//set everything to start condition
		if (rst) begin
			address <= address_in;
			address_out <= 14'h0;
		end
		else begin
			if (vDS && vDE256) begin //if we completed all the memory reading
				//aumentar direccion de memoria	
				
				if(hDS && hDE256) begin
					
					count8 <=count8+4'd1;
				
					
					if(count8 == 4'd7) begin

						address <= address + 14'h1;
						count8 <=3'd0;
					end
					
					else if(count8 == 4'd0)begin
					
						if(x < (HSS + 10'd2))begin
							r <= 8'h00;
							g <= 8'h00;
							b <= 8'h00;		
					
						end
						else begin
							r <= memory_data[7:0];
							g <= memory_data[7:0];
							b <= memory_data[7:0];
						end

					end
					
					else if(count8 == 4'd4)begin
					
						if(x < (HSS + 10'd2))begin
							r <= 8'h00;
							g <= 8'h00;
							b <= 8'h00;	
					
						end
						else begin
							r <= memory_data[15:8];
							g <= memory_data[15:8];
							b <= memory_data[15:8];
						end

					end
			


				end
				
				else if (hDE256E) begin 
					flag_row <= flag_row + 3'b01;
					flag_row_fix <= ~flag_row_fix;
					if(flag_row == 3'b111 || flag_row == 3'b011) begin
						address <= address - 14'd64;
						//address_out <= address;
					end
//					else if(flag_row == 2'b00) begin
//						address <= address + 14'h1;
//						address_out <= address;
//					end
					r <= 8'h00;
					g <= 8'hFF;
					b <= 8'h00;
					
				end 
				else if(x == HMAX)begin
				
					r <= 8'h00;
					g <= 8'h00;
					b <= 8'h00;	
					
				end
	
				else begin
					r <= 8'hFF;
					g <= 8'hFF;
					b <= 8'hFF;	
				
				end
				
				
				address_out <= address;
				
			end
			

			else begin 
				r <= 8'hFF;
				g <= 8'hFF;
				b <= 8'hFF;
				address <= 14'h0; 
				address_out <= address;	
			end

		end
	end


	
endmodule

