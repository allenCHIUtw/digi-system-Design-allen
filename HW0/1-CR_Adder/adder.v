module adder(x, y, carry, out);
input [7:0] x, y;
output carry;
output [7:0] out;
reg co[6:0];
/*Write your code here*/
assign {co[0],out[0]}=x[0]+y[0];
assign {co[1],out[1]}=x[1]+y[1]+co[0];
assign {co[2],out[2]}=x[2]+y[2]+co[1];
assign {co[3],out[3]}=x[3]+y[3]+co[2];
assign {co[4],out[4]}=x[4]+y[4]+co[3];
assign {co[5],out[5]}=x[5]+y[5]+co[4];
assign {co[6],out[6]}=x[6]+y[6]+co[5];
assign {carry,out[7]}=x[7]+y[7]+co[6];
/*End of code*/

endmodule