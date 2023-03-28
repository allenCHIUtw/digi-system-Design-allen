`include "../2-RegisterFile/register_file.v"
`include "../1-ALU/2_always/alu_always.v"

module simple_calculator(
    Clk,
    WEN,
    RW,
    RX,
    RY,
    DataIn,
    Sel,
    Ctrl,
    busY,
    Carry
);

    input        Clk;
    input        WEN;
    input  [2:0] RW, RX, RY;
    input  [7:0] DataIn;
    input        Sel;
    input  [3:0] Ctrl;
    output [7:0] busY;
    output       Carry;

// declaration of wire/reg
  wire [7:0] ALU_out ,REG_X_read,REG_Y_read;
  wire [7:0] MUX_out ;

// submodule instantiation.
    
      register_file RGF(.Clk(Clk),.WEN(WEN),
                       .RW(RW),.busW(ALU_out),.RX(RX),
                       .RY(RY),.busX(REG_X_read),.busY(REG_Y_read));
      assign MUX_out   =   (Sel == 1'b0) ? DataIn : REG_X_read;
      assign busY =REG_Y_read;
      alu_always ALU(.ctrl(Ctrl),.x(MUX_out),.y(REG_Y_read),.carry(Carry),.out(ALU_out) );
//     alu_assign(
//     ctrl,
//     x,
//     y,
//     carry,
//     out  
// );

// register_file(
//     Clk  ,
//     WEN  ,
//     RW   ,
//     busW ,
//     RX   ,
//     RY   ,
//     busX ,
//     busY
// );

endmodule
