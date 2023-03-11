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

parameter reg_count=8;
integer index;
// write your design here, you can delcare your own wires and regs. 
// The code below is just an eaxmple template
// reg [7:0] r0_w, r1_w, r2_w, r3_w, r4_w, r5_w, r6_w, r7_w;
// reg [7:0] r0_r, r1_r, r2_r, r3_r, r4_r, r5_r, r6_r, r7_r;
reg [7:0] reg_w [0:7];
reg [7:0] reg_r [0:7];
reg [7:0] DC_write;
wire [7:0] clk_enable;

initial begin
    for(index=0; index<reg_count; index=index+1)begin
     reg_w[index]=8'd0;
     reg_r[index]=8'd0;
     DC_write[index]=1'b0;
    end
end
decoder DC3_8(DC_write,RW[2],RW[1],RW[0]);
always @(*) begin
  case(RX)
    3'd0: assign busX=reg_r[0];
    3'd1: assign busX=reg_r[1];
    3'd2: assign busX=reg_r[2];
    3'd3: assign busX=reg_r[3];
    3'd4: assign busX=reg_r[4];
    3'd5: assign busX=reg_r[5];
    3'd6: assign busX=reg_r[6];
    3'd7: assign busX=reg_r[7];
  endcase
 case(RY)
    3'd0: assign busY=reg_r[0];
    3'd1: assign busY=reg_r[1];
    3'd2: assign busY=reg_r[2];
    3'd3: assign busY=reg_r[3];
    3'd4: assign busY=reg_r[4];
    3'd5: assign busY=reg_r[5];
    3'd6: assign busY=reg_r[6];
    3'd7: assign busY=reg_r[7];
  endcase 
end


for(idx=0; idx<reg_count; idx=idx+1)
  assign clk_enable[idx]=DC_write[idx] & Clk;

always @(posedge Clk) begin
   for(idx=0; idx<reg_count; idx++) begin
     if(clk_enable[idx]) reg_r<= busW;
     else reg_r<=reg_w;
   end
   
end

endmodule
module decoder(decoded,a_4,a_2,a_1);
output [7:0 ]decoded;
input a_4, a_2, a_1;
wire inv_4,inv_2,inv_1;
assign inv_4=      ~a_4;
assign inv_2=      ~a_2;
assign inv_1=      ~a_1l
 
assign decoded[0]= inv_4 & inv_2 & inv_1;
assign decoded[1]= inv_4 & inv_2 & a_1;
assign decoded[2]= inv_4 & a_2 & inv_1;
assign decoded[3]= inv_4 & a_2 & a_1;
assign decoded[4]= a_4 & inv_2 & inv_1;
assign decoded[5]= a_4 & inv_2 & a_1;
assign decoded[6]= a_4 & a_2 & inv_1;
assign decoded[7]= a_4 & a_2 & a_1;


endmodule

module W_control(flow_o , control ,flow_i)
input  [7:0] flow_i;
output [7:0] flow_o;
input        control;

for(idx=0; idx<size; idx=idx+1)
   assign flow_o[idx]=control? flow_i[idx]:0;
endmodule