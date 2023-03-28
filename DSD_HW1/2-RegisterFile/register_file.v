module register_file(
    Clk  ,
    WEN  ,
    RW   ,
    busW ,
    RX   ,
    RY   ,
    busX ,
    busY
);
input        Clk, WEN;
input  [2:0]  RW, RX, RY;
input  [7:0]  busW;
output [7:0]  busX, busY;

parameter reg_count=8;
integer idx;
// write your design here, you can delcare your own wires and regs. 
// The code below is just an eaxmple template
reg [7:0] reg_w [0:7];
reg [7:0] reg_r [0:7];
 
  assign  busX  =(RX == 3'b000 )?8'd0: reg_r[RX];
  assign  busY = (RY == 3'b000 )?8'd0: reg_r[RY];
 


always @(posedge Clk  ) begin
  
    if(WEN == 1'b1) begin
      reg_r[RW]   <= busW;
    end
end

endmodule