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
    output reg      carry;
    output reg [7:0] out;
    //regs
    //reg [7:0] out_temp;


    parameter  ADD    =4'd0;
    parameter  SUB    =4'd1;
    parameter  BITAND =4'd2;
    parameter  BITOR  =4'd3;
    parameter  BITNOT =4'd4;
    parameter  BITXOR =4'd5;
    parameter  BITNOR =4'd6;
    parameter  SRL    =4'd7;
    parameter  SRR    =4'd8;
    parameter  SRA    =4'd9;
    parameter  RL     =4'd10;
    parameter  RR     =4'd11;
    parameter  EQ     =4'd12;
    always @(*) begin
        case(ctrl)
        //  ADD:     {carry,out}=x+y;//{carry,out } 9 b
        //  SUB:     {carry,out}=x-y;
         ADD: begin 
          
           {carry,out}={x[7],x}+{y[7],y};
         end
         SUB:begin
            {carry,out}={x[7],x}-{y[7],y};
         end
         BITAND:  begin 
                  out        =x & y;
                  carry      =1'b0;
         end
         BITOR:    begin 
                  out        =x | y;
                  carry      =1'b0;
         end
         BITNOT:  begin
                  out        =~x;
                  carry      =1'b0;
         end
         BITXOR: begin 
                  out        =x ^ y;
                  carry      =1'b0;
         end
         BITNOR: begin 
                  out        =~(x | y);
                  carry      =1'b0;
         end
         SRL:    begin
                  out        =y<<x[2:0];
                  carry      =1'b0;
         end
         SRR:     begin
                  out        =y>>x[2:0];
                  carry      =1'b0;
         end
         SRA:     begin
                  out        ={x[7],x[7:1]};
                  carry      =1'b0;
         end
         RL:      begin
                  out        ={x[6:0],x[7]};
                  carry      =1'b0;
         end
         RR:      begin
                  out        ={x[0],x[7:1]};
                  carry      =1'b0;
         end
         EQ:      begin 
                  out        =(x==y)?8'd1:8'd0;
                  carry      =1'b0;
         end
         default: begin
                  out        =8'b0;
                  carry      =1'b0;
         end
        endcase
    end

endmodule
