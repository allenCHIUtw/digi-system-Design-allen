module adder_gate(x, y, carry, out);
input [7:0] x, y;
output carry;
output [7:0] out;
wire [8:0]carry_out;

/*Write your code here*/
genvar  idx;
generate
for(idx=0; idx<8; idx=idx+1)
 begin
    full_adder fa(,,out[idx],);
 end
endgenerate



/*End of code*/

endmodule

module full_adder(xb,yb,cin,sum,cout);
input xb,yb,cin
output sum ,cout;
wire [2:0]wr;
xor xo0(wr[0],xb,yb);
xor xo1(sum,wr[0],cin);
nand na0(wr[1],xb,yb);
nand na1(wr[2],wr[0],cin);
nand na2(cout,wr[1],wr[2]);

   
endmodule