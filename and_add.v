/*
A module in Galois field multiplication in GF(2^13)
Takes in two field elements in PB representation, computes the BITWISE AND, adds them modulo - 2
and outputs a single bit.
*/
module and_add(a1,a2,a3);
input [12:0] a1,a2;
output a3;
wire [12:0] a1,a2;
wire a3;

wire out1,out2,out3,out4,out5,out6,out7,out8,out9,out10,out11,out12,out13;
//Bitwise AND
assign out1 = a1[0] & a2[0];
assign out2 = a1[1] & a2[1];
assign out3 = a1[2] & a2[2];
assign out4 = a1[3] & a2[3];
assign out5 = a1[4] & a2[4];
assign out6 = a1[5] & a2[5];
assign out7 = a1[6] & a2[6];
assign out8 = a1[7] & a2[7];
assign out9 = a1[8] & a2[8];
assign out10 = a1[9] & a2[9];
assign out11 = a1[10] & a2[10];
assign out12 = a1[11] & a2[11];
assign out13 = a1[12] & a2[12];

assign a3 = out1 ^ out2 ^ out3 ^ out4 ^ out5 ^ out6 ^ out7 ^ out8 ^ out9 ^ out10 ^ out11 ^ out12 ^ out13;

endmodule // End of module

