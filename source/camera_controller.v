
module camera_controller(vsync,href,pclk,we,addr);

parameter TP = 2; //Pixel time
parameter RAW_VSIZE = 480;// Raw vertical size
parameter RAW_HSIZE = 640;// Raw horizontal size
parameter CAP_VSIZE = 120;// Capture verical size
parameter CAP_HSIZE = 160;// Capture Vertical size

parameter ADDR_BITS = 14;// Address bits for

input vsync;
input href;
input pclk;
output we;
output [addr_bits-1:0] addr;

reg [addr_BITS:0] Addr_counter;
reg [10:0] h_counter;
reg [10:0] v_counter;

//Count the position inside the screen
always@(posedge pclk)begin
    if(vsync)begin
        h_counter <= 0;
        v_counter <= 0;
    end
    else(href)begin
        if(h_counter < (RAW_HSIZE * TP - 1))
            h_counter <= h_counter + 1;
        else begin
            h_counter <= 0;
            v_counter <= v_counter + 1;
        end
    end
end

//Define the capture region
assign is_capture_region = (v_counter < CAP_VSIZE) and (h_counter < (CAP_HSIZE * TP));

//Memory address counter
always@(posedge pclk)begin
    if(vsync)
        addr_counter <= 0;
    else if(href and is_capture_region)
        addr_counter <= addr_counter + 1;
end

//Only the Y (grayscale) component of every pixel is captured (see datasheet)
assign addr = addr_counter[ADDR_BITS:1];
assign we = addr_counter[0] and href and is_capture_region;

endmodule
