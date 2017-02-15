
module double_port_ram(clk_w,addr_w,data_w,en_w,clk_r,addr_r,data_r);

parameter RAM_WIDTH = 8;
parameter RAM_ADDR_BITS = 14;

input clk_w;
input [RAM_ADDR_BITS-1:0] addr_w;
input [RAM_WIDTH-1:0] data_w;
input en_w;
input clk_r;
input [RAM_ADDR_BITS-1:0] addr_r;
output reg [RAM_WIDTH-1:0] data_r;

reg [RAM_WIDTH-1:0] ram [(2**RAM_ADDR_BITS)-1:0];

always @(posedge clk_w)
    if (en_w)
        ram[addr_w] <= data_w;

always @(posedge clk_r)
        data_r <= ram[addr_r];

endmodule
