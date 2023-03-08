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
input  [2:0] RW, RX, RY;
input  [7:0] busW;
output [7:0] busX, busY;

parameter size=8;
integer  i;;
// write your design here, you can delcare your own wires and regs. 
// The code below is just an eaxmple template
// reg [7:0] r0_w, r1_w, r2_w, r3_w, r4_w, r5_w, r6_w, r7_w;
// reg [7:0] r0_r, r1_r, r2_r, r3_r, r4_r, r5_r, r6_r, r7_r;

reg [7:0] reg_w[0:7];
reg [7:0] reg_r[0:7];


//==================Combinational===================
always@(*) begin

end
//==================Combinational===================

//==================Sequential===================
always@(posedge Clk) begin
if(!WEN)begin
//   reg_r[0] <= 8'd0;
//   reg_r[1] <= 8'd0; 
//   reg_r[2] <=  8'd0;
//   reg_r[3] <=  8'd0;
//   reg_r[4] <= 8'd0;
//   reg_r[5] <= 8'd0;
//   reg_r[6] <= 8'd0;
//   reg_r[7] <= 8'd0;
  for(i=0 ; i<size; i=i+1)
   reg_r[i]<=reg_w[i];
end
else begin
 

end
//==================Sequential===================
end	

endmodule
// ===============my modules================
module mux_8to1();
endmodule