module adder(x, y, carry, out);
input [7:0] x, y;
output carry;
output [7:0] out;
reg ans[8:0];
/*Write your code here*/
assign ans=x+y;
out=ans[7:0];
carry=ans[8];

/*End of code*/

endmodule