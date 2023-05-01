`timescale 1ns/10ps
module GSIM ( clk, reset, in_en, b_in, out_valid, x_out);
   input   clk ;
   input   reset;
   input   in_en;
   output  out_valid;
   input   [15:0]  b_in;
   output  [31:0]  x_out;

   ALUCELL alu01(.clk(),.reset() , .i_b() , .i_prd3(),.i_prd2(),.i_prd1(),.i_suc1(),.i_suc2(),.i_suc3() ,.o_x());
   ALUCELL alu02(.clk(),.reset() , .i_b() , .i_prd3(),.i_prd2(),.i_prd1(),.i_suc1(),.i_suc2(),.i_suc3() ,.o_x());
 
endmodule

module ALUCELL(clk,reset , i_b ,i_prd3,i_prd2,i_prd1,i_suc1,i_suc2,i_suc3 ,o_x)
  input clk,reset;
  input  [31:0] i_prd3,i_prd2,i_prd1,i_suc1,i_suc2,i_suc3;
  input  [15:0] i_b;
  output [31:0] o_x;

  wire [31:0] b_11 ;
  reg  [31:1] b

  assign b_11 = {i_b,16'd0}; //
  assign o_x = 

  reg [31:0] r_1

  always @(*) begin 

  end

  always @(posedge clk ) begin 

  end
endmodule