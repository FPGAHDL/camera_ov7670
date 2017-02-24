module toplevel(clk_50,sw,vga_R,vga_G,vga_B,vga_HSync,vga_Vsync);

input clk_50;
input [0:0] sw;
output [2:0] vga_R;
output [2:0] vga_G;
output [1:0] vga_B;
output vga_HSync;
output vga_Vsync;

assign rst = sw;
wire  vga_clk;

clockdiv U1(
	.clk_50(clk_50),
	.rst(rst),
	.clk_25(vga_clk)
);

//internal h v  and r g b signals
//wire [9:0] h;
//wire [9:0] v;
wire [2:0] r = 3'b111;
wire [2:0] g = 0;
wire [1:0] b = 0;

vga640x480 U3(
	.dclk(vga_clk),
	.clr(rst),
	.i_red(r),
	.i_green(g),
	.i_blue(b),
	.hsync(vga_HSync),
	.vsync(vga_Vsync),
	.red(vga_R),
	.green(vga_G),
	.blue(vga_B)
);

endmodule
