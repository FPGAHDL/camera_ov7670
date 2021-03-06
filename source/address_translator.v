module address_translator(h,v,address,blackout);

parameter ADDR_BITS = 15;

input [9:0] h;
input [9:0] v;
output [ADDR_BITS-1:0] address;
output blackout;

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

wire [9:0] h_corrected = h;
wire [9:0] v_corrected = v;
wire [ADDR_BITS:0] address_base_v = v_corrected * IMAGE_SIZE_H; 
wire [ADDR_BITS:0] address_calc = address_base_v + h_corrected;

wire isValid_image = ((h_corrected < IMAGE_SIZE_H) && (v_corrected < IMAGE_SIZE_V)) ? 1 : 0;
 
assign address = (isValid_image) ? address_calc[ADDR_BITS-1:0] : 0;
assign blackout = ~isValid_image;

endmodule