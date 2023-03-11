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
  reg [7:0]AlU_out ,MUX_out,REG_X_read,REG_Y_read;

// submodule instantiation
    
      register_file rg(Clk,WEN,RW,AlU_out,RX,RY,busX,busY);
       assign MUX_out=(Sel)?AlU_out:DataIn;
      alu_always ALU(ctrl,MUX_out,REG_Y_read,.carry(Carry),ALU_out );
   


endmodule
