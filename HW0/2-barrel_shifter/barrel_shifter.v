module barrel_shifter(in, shift, out);
input  [7:0] in;
input  [2:0] shift;
output [7:0] out;

/*Write your code here*/
wire [7:0]intermidline[0:2];

mux2to1 mux_ly1_1(.rst(),.ctr(shift[0]),.one(),.zero());
mux2to1 mux_ly1_2(.rst(),.ctr(shift[0]),.one(),.zero());
mux2to1 mux_ly1_3(.rst(),.ctr(shift[0]),.one(),.zero());
mux2to1 mux_ly1_4(.rst(),.ctr(shift[0]),.one(),.zero());
mux2to1 mux_ly1_5(.rst(),.ctr(shift[0]),.one(),.zero());
mux2to1 mux_ly1_6(.rst(),.ctr(shift[0]),.one(),.zero());
mux2to1 mux_ly1_7(.rst(),.ctr(shift[0]),.one(),.zero());
mux2to1 mux_ly1_8(.rst(),.ctr(shift[0]),.one(),.zero());

mux2to1 mux_ly2_1(.rst(),.ctr(shift[1]),.one(),.zero());
mux2to1 mux_ly2_2(.rst(),.ctr(shift[1]),.one(),.zero());
mux2to1 mux_ly2_3(.rst(),.ctr(shift[1]),.one(),.zero());
mux2to1 mux_ly2_4(.rst(),.ctr(shift[1]),.one(),.zero());
mux2to1 mux_ly2_5(.rst(),.ctr(shift[1]),.one(),.zero());
mux2to1 mux_ly2_6(.rst(),.ctr(shift[1]),.one(),.zero());
mux2to1 mux_ly2_7(.rst(),.ctr(shift[1]),.one(),.zero());
mux2to1 mux_ly2_8(.rst(),.ctr(shift[1]),.one(),.zero());

mux2to1 mux_ly3_1(.rst(output[7]),.ctr(shift[2]),.one(),.zero());
mux2to1 mux_ly3_2(.rst(output[6]),.ctr(shift[2]),.one(),.zero());
mux2to1 mux_ly3_3(.rst(output[5]),.ctr(shift[2]),.one(),.zero());
mux2to1 mux_ly3_4(.rst(output[4]),.ctr(shift[2]),.one(),.zero());
mux2to1 mux_ly3_5(.rst(output[3]),.ctr(shift[2]),.one(),.zero());
mux2to1 mux_ly3_6(.rst(output[2]),.ctr(shift[2]),.one(),.zero());
mux2to1 mux_ly3_7(.rst(output[1]),.ctr(shift[2]),.one(),.zero());
mux2to1 mux_ly3_8(.rst(output[0]),.ctr(shift[2]),.one(),.zero());
/*End of code*/
endmodule

module mux2to1(rst,ctr,one ,zero);
input ctr,one,zero;
output rst;
assign rst=(ctr)?one:zero;
endmodule