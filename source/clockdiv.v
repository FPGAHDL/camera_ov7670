module clockdiv(
    input clk_50,//master clock: 50MHz
    input rst,//syncrounous reset
    output clk_25,//derivated clock: 25MHz
    output clk_12_5//derivated clock: 12.5MHz
    );

// 2 bit counter variable
reg [1:0] q;

always @(posedge clk_50)
begin
    if (rst == 1)
        q <= 0;
    else
        q <= q + 1;
end

// 50Mhz  2^1 = 25MHz
assign clk_25 = q[0];
assign clk_12_5 = q[1];

endmodule
