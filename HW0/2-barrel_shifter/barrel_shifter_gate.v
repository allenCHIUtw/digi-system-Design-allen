module barrel_shifter_gate(in, shift, out);
input  [7:0] in;
input  [2:0] shift;
output [7:0] out;

/*Write your code here*/

genvar row=3;
genvar column=8;
generate
    for (idx=0 ;idx<row; idx=idx+1)
    begin
        for(idy=0; idy<column; idy=idy+1)
        begin
            mux mxthe(.x(),.a(),.b(),.c());
        end
    end
endgenerate
/*End of code*/
endmodule

module mux (x,a,b,sel);
input 	a,b,sel;
output 	x;
wire sel_i,w1,w2;

not n0(sel_i,sel);
and a1(w1,a,sel_i);
and a2(w2,b,sel);
or  o1(x,w1,w2);

	
endmodule
