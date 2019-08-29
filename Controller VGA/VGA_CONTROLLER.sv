module VGA_CONTROLLER #(parameter HACTIVE = 10'd635,
											HFP = 10'd15,
											HSYN = 10'd95,
											HBP = 10'd48,
											HMAX = HACTIVE + HFP + HSYN + HBP,
											VBP = 10'd33,//38,
											VACTIVE = 10'd480,
											VFP = 10'd10,//11,
											VSYN = 10'd2,
											VMAX = VACTIVE + VFP + VSYN + VBP)
(input logic vgaclk, reset,
output logic hsync, vsync, sync_b, blank_b,
output logic [9:0] hcnt, vcnt);

//initialize values




// counters for horizontal and vertical positions
always_ff @(posedge vgaclk, posedge reset) begin
	//set everything to start condition
	if (reset) begin
		hcnt = 0;
		vcnt = 0;
	end
	else begin
	hcnt = hcnt + 10'b01; //increment horizontal count
	if (hcnt == HMAX) begin //if we completed one horizontal cycle
		hcnt = 0;//return count to 0
		vcnt = vcnt + 10'b01; //increment vertical counter
		if (vcnt == VMAX) vcnt = 0; //return counter to 0 when we reach end of cycle
	end
	end
end

// Compute sync signals (active low)
assign hsync = ~((hcnt >= (HACTIVE + HFP)) & (hcnt < (HACTIVE + HFP + HSYN)));
assign vsync = ~((vcnt >= (VACTIVE + VFP)) & (vcnt < (VACTIVE + VFP + VSYN)));
assign sync_b = hsync & vsync;
// Force outputs to black when outside the legal display area
assign blank_b = (hcnt < HACTIVE) & (vcnt < VACTIVE);

endmodule