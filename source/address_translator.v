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

wire [9:0] h_corrected = h;
wire [9:0] v_corrected = v;
wire [15:0] address_base_v = v_corrected * IMAGE_SIZE_H; 
wire [15:0] address_calc = address_base_v + h_corrected;

wire isValid_image = ((h_corrected < IMAGE_SIZE_H) && (v_corrected < IMAGE_SIZE_V)) ? 1 : 0;
 
assign address = (isValid_image) ? address_calc : 0;

endmodule