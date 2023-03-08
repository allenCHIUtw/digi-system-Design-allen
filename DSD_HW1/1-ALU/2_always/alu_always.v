//RT �Vlevel (event-driven) 
module alu_always(
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
    //regs
    reg [7:0] out_temp;
    
    parameter  ADD    =4'b0000;
    parameter  SUB    =4'b0001;
    parameter  BITAND =4'b0010;
    parameter  BITOR  =4'b0011;
    parameter  BITNOT =4'b0100;
    parameter  BITXOR =4'b0101;
    parameter  BITNOR =4'b0110;
    parameter  SRL    =4'b0111;
    parameter  SRR    =4'b1000;
    parameter  SRA    =4'b1001;
    parameter  RL     =4'b1010;
    parameter  RR     =4'b1011;
    parameter  EQ     =4'b1100;

    always @(*) begin
        case(ctrl)
         ADD:     out=x+y;
         SUB:     out=x-y;
         BITAND:  out=x & y;
         BITOR:    out=x | y;
         BITNOT:   out=~x;
         BITXOR:  out=x ^ y;
         BITNOR:   out=~(x | y);
         SRL:     out=y<<x[2:0];
         SRR:     out=y>>x[2:0];
         SRA:     out={x[7],x[7:1]};
         RL:      out={x[6:0],x[7]};
         RR:      out={0,x[7:1]};
         EQ:      out=(x==y)?8'd1:8'd0;
         
         default:out=8'b0;

        endcase
    end

endmodule
