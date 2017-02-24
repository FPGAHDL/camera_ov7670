
module image_rom(clk_r,addr_r,data_r);

parameter ROM_WIDTH = 8;
parameter ROM_ADDR_BITS = 15;
parameter IMAGE_SIZE = 160*120;
input clk_r;
input [ROM_ADDR_BITS-1:0] addr_r;
output reg [ROM_WIDTH-1:0] data_r;

reg [ROM_WIDTH-1:0] rom [IMAGE_SIZE-1:0];

initial
    $readmemh("myimage.hex",rom,0,IMAGE_SIZE-1);
    
always @(posedge clk_r)
        data_r <= rom[addr_r];

endmodule
