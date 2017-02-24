module toplevel(clk_50,sw,vga_R,vga_G,vga_B,vga_HSync,vga_Vsync,
    OV7670_PWDN,OV7670_RESET, OV7670_DATA, OV7670_XCLK, OV7670_PCLK, OV7670_HREF, OV7670_VSYNC);


input clk_50;
input [0:0] sw;
output [2:0] vga_R;
output [2:0] vga_G;
output [1:0] vga_B;
output vga_HSync;
output vga_Vsync;

output OV7670_PWDN;
output OV7670_RESET;
input [7:0] OV7670_DATA;
output OV7670_XCLK;
input OV7670_PCLK;
input OV7670_HREF;
input OV7670_VSYNC;

assign rst = sw;
wire  vga_clk;

parameter ADDR_BITS = 15;

clockdiv U1(
    .clk_50(clk_50),
    .rst(rst),
    .clk_25(vga_clk),
    .clk_12_5(OV7670_XCLK)
);

//internal h v  and r g b signals
wire [9:0] h;
wire [9:0] v;
wire [2:0] r ;
wire [2:0] g ;
wire [1:0] b = 0;
wire [7:0] data_raw;
wire [ADDR_BITS-1:0] address;
wire blackout;

address_translator U2(
    .v(v),
    .h(h),
    .address(address),
    .blackout(blackout)
);


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
    .blue(vga_B),
    .h(h),
    .v(v)
);

wire [ADDR_BITS-1:0] addr_w;
wire we;

camera_controller camera(
    .vsync(OV7670_VSYNC),
    .href(OV7670_HREF),
    .pclk(OV7670_PCLK),
    .we(we),
    .addr(addr_w)
);


double_port_ram ram(
    .clk_w(OV7670_PCLK),
    .addr_w(addr_w),
    .data_w(OV7670_DATA),
    .en_w(we),
    .clk_r(vga_clk),
    .addr_r(address),
    .data_r(data_raw)
);

wire [7:0] data = (blackout) ? 0 : data_raw;

assign r = data[7:5];
assign g = data[7:5];

assign  OV7670_PWDN = 0;
assign  OV7670_RESET = 1;

endmodule
