
module camera_controller(vsync,href,pclk,we,addr);

parameter VSIZE = 120;
parameter HSIZE = 160;
parameter ADDR_BITS = 14;

input vsync;
input href;
input pclk;
output we;
output [ADDR_BITS-1:0] addr;

reg [ADDR_BITS:0] addr_counter;

always@(posedge pclk)begin
    if(vsync)
        addr_counter <= 0; 
    else if(href) 
        addr_counter <= addr_counter + 1;
end


assign addr = addr_counter[ADDR_BITS:1];
assign we = addr_counter[0] & href;

endmodule
