module address_translator(h,v,address);

input [9:0] h;
input [9:0] v;
output [15:0] address;

parameter hpixels = 800;// horizontal pixels per line
parameter vlines = 521; // vertical lines per frame
parameter hpulse = 96; 	// hsync pulse length
parameter vpulse = 2; 	// vsync pulse length
parameter hbp = 144; 	// end of horizontal back porch
parameter hfp = 784; 	// beginning of horizontal front porch
parameter vbp = 31; 		// end of vertical back porch
parameter vfp = 511; 	// beginning of vertical front porch

parameter IMAGE_SIZE_V = 120;
parameter IMAGE_SIZE_H = 160;

assign isValid = ((v >= vbp) && (v < vfp) && (h >= hbp) && (h < hfp)) ? 1 : 0;

wire [15:0] address_calc = (v-vbp)*IMAGE_SIZE*IMAGE_SIZE_H + (h-hbp);

assign address = (isValid) ? address_calc : 0;

endmodule
