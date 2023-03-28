//RTL (use continuous assignment)
module alu_assign(
    ctrl,
    x,
    y,
    carry,
    out  
);
    
    input      [3:0] ctrl;
    input      [7:0] x;
    input      [7:0] y;
    output     carry;
    output  [7:0] out;

    wire [8:0]signed_add,signed_sub,bitand,bitor,bitnot,bitxor;
    wire [8:0]bitnor,sllv,srlv,sra,rl,rr,eq;
    wire [7:0] temp[0:10];

    assign signed_add   ={x[7],x}+{y[7],y};

    assign signed_sub   ={x[7],x}-{y[7],y};
 
    assign temp[0]      =x & y;
    assign bitand       ={1'b0,temp[0]};

    assign temp[1]      =x | y;
    assign bitor        ={1'b0,temp[1]};

    assign temp[2]      =~x;
    assign bitnot       ={1'b0,temp[2]};

    assign temp[3]      =x ^ y;
    assign bitxor       ={1'b0,temp[3]};

    assign temp[4]      =~(x | y);
    assign bitnor       ={1'b0,temp[4]};

    assign temp[5]      =y<<x[2:0];
    assign sllv          ={1'b0,temp[5]};

    assign temp[6]      =y>>x[2:0];
    assign srlv          ={1'b0,temp[6]};

    assign temp[7]      ={x[7],x[7:1]};
    assign sra          ={1'b0,temp[7]};

    assign temp[8]      ={x[6:0],x[7]};
    assign rl           ={1'b0,temp[8]};

    assign temp[9]      ={x[0],x[7:1]};
    assign rr           ={1'b0,temp[9]};
    
    assign temp[10]     =(x==y)?8'd1:8'd0;
    assign eq           ={1'b0,temp[10]};

    assign {carry,out}=(ctrl==4'd0)?  signed_add
                      :(ctrl==4'd1)?  signed_sub
                      :(ctrl==4'd2)?  bitand
                      :(ctrl==4'd3)?  bitor
                      :(ctrl==4'd4)?  bitnot
                      :(ctrl==4'd5)?  bitxor
                      :(ctrl==4'd6)?  bitnor
                      :(ctrl==4'd7)?  sllv
                      :(ctrl==4'd8)?  srlv
                      :(ctrl==4'd9)?  sra
                      :(ctrl==4'd10)? rl
                      :(ctrl==4'd11)? rr
                      :(ctrl==4'd12)? eq
                      :9'd0;

    

endmodule
