module barrel_shifter_gate(in, shift, out);
input  [7:0] in;
input  [2:0] shift;
output [7:0] out;

/*Write your code here*/
/*
parameter column=8;
genvar idx_0;
generate
    for (idx_0=0 ;idx_0<column; idx_0=idx_0+1)
     begin
     mux muxmode(.x(),.a(),.b(),.sel());
     end
endgenerate
genvar idx_1;
generate
    for (idx_1=0 ;idx_1<column; idx_1=idx_1+1)
     begin
     mux muxmode(.x(),.a(),.b(),.sel());
     end
endgenerate
genvar idx_2;
generate
    for (idx_2=0 ;idx_2<column; idx_2=idx_2+1)
     begin
     mux muxmode(.x(),.a(),.b(),.sel());
     end
endgenerate*/
mux muxly1_1(,,,);
mux muxly1_2(,,,);
mux muxly1_3(,,,);
mux muxly1_4(,,,);
mux muxly1_5(,,,);
mux muxly1_6(,,,);
mux muxly1_7(,,,);
mux muxly1_8(,,,);

mux muxly2_1(,,,);
mux muxly2_2(,,,);
mux muxly2_3(,,,);
mux muxly2_4(,,,);
mux muxly2_5(,,,);
mux muxly2_6(,,,);
mux muxly2_7(,,,);
mux muxly2_8(,,,);

mux muxly3_1(,,,);
mux muxly3_2(,,,);
mux muxly3_3(,,,);
mux muxly3_4(,,,);
mux muxly3_5(,,,);
mux muxly3_6(,,,);
mux muxly3_7(,,,);
mux muxly3_8(,,,);
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
