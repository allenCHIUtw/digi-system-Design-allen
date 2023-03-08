module barrel_shifter_gate(in, shift, out);
input  [7:0] in;
input  [2:0] shift;
output [7:0] out;

/*Write your code here*/
mux muxly1_1(.x(),.a(),.b(),.sel());
mux muxly1_2(.x(),.a(),.b(),.sel());
mux muxly1_3(.x(),.a(),.b(),.sel());
mux muxly1_4(.x(),.a(),.b(),.sel());
mux muxly1_5(.x(),.a(),.b(),.sel());
mux muxly1_6(.x(),.a(),.b(),.sel());
mux muxly1_7(.x(),.a(),.b(),.sel());
mux muxly1_8(.x(),.a(),.b(),.sel());

mux muxly2_1(.x(),.a(),.b(),.sel());
mux muxly2_2(.x(),.a(),.b(),.sel());
mux muxly2_3(.x(),.a(),.b(),.sel());
mux muxly2_4(.x(),.a(),.b(),.sel());
mux muxly2_5(.x(),.a(),.b(),.sel());
mux muxly2_6(.x(),.a(),.b(),.sel());
mux muxly2_7(.x(),.a(),.b(),.sel());
mux muxly2_8(.x(),.a(),.b(),.sel());

mux muxly3_1(.x(),.a(),.b(),.sel());
mux muxly3_2(.x(),.a(),.b(),.sel());
mux muxly3_3(.x(),.a(),.b(),.sel());
mux muxly3_4(.x(),.a(),.b(),.sel());
mux muxly3_5(.x(),.a(),.b(),.sel());
mux muxly3_6(.x(),.a(),.b(),.sel());
mux muxly3_7(.x(),.a(),.b(),.sel());
mux muxly3_8(.x(),.a(),.b(),.sel());
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
