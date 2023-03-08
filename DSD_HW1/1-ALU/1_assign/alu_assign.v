//RTL (use continuous assignment)
module alu_assign(
    ctrl,
    x,
    y,
    carry,
    out  
);
    
    input  [3:0] ctrl;
    input  [7:0] x;
    input  [7:0] y;
    output       carry;
    output [7:0] out;
    reg [8:0]temp;
    //
    parameter  ADD    =4'b0000;
    parameter  SUB    =4'b0001;
    parameter  BITAND =4'b0010;
    parameter  BITOR  =4'b0011;
    parameter  BITNOT =4'b0100;
    parameter  BITXOR =4'b0101;
    parameter  BITNOR =4'b0110;
    parameter  SRL    =4'b0111;
    parameter  SRL    =4'b1000;
    parameter  SRA    =4'b1001;
    parameter  RL     =4'b1010;
    parameter  RR     =4'b1011;
    parameter  EQ     =4'b1100;
    //
    case(ctrl)
       ADD: begin
        assign temp=x+y;
        assign out=temp[7:0];
        assign carry=temp[8];
       end
       SUB:begin
         assign temp=x-y;
        assign out=temp[7:0];
        assign carry=temp[8];
       end
       BITAND: assign out =x & y;
       BITOR:  assign out =x | y;
       BITNOT: assign out =~x;
       BITXOR: assign out =x^y;
       BITNOR: assign out =~(x | y);
       SRL:    assign out =;
       SRR:    assign out =;
       SRA:    assign out =;
       RL:     assign out =;
       RR:     assign out =;
       EQ:     assign out =(x==y)?8'b1:8'b0;
       default assign out =8'd0;
       
    endcase
    

endmodule
