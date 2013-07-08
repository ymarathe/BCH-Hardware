/*
Computes the inverse of a field element in GF(2^13). 
All the computations are parallelized by unfolding the serial implementation in inverse.v into a balanced tree.
Takes in a field elemet a and outputs a field element b, which is the inverse.
Both a and b are in PB representation.
*/
module parallel_inverse(a,b);
input [12:0] a; //Input
output [12:0] b; //Output
wire [12:0] a, b;

/*
Declare intermediate lines.
power_i_q represents the ith power of the field element a.
mult_ij_q represents the product of the ith power of a and jth power of a.
*/
wire [12:0] power_2_q, power_4_q, power_8_q, power_16_q, power_32_q, power_64_q, power_128_q, power_256_q, power_512_q, power_1024_q, power_2048_q, power_4096_q;
wire [12:0] mult_24_q, mult_816_q, mult_3264_q, mult_128256_q, mult_5121024_q, mult_20484096_q;
wire [12:0] mult_216_q, mult_32256_q, mult_5124096_q;
wire [12:0] mult_2256_q;

//Wire appropriately to generate mult_ij_q
pb_mult_new u1(power_2_q, power_4_q, mult_24_q);
pb_mult_new u2(power_8_q, power_16_q, mult_816_q);
pb_mult_new u3(power_32_q, power_64_q, mult_3264_q);
pb_mult_new u4(power_128_q, power_256_q, mult_128256_q);
pb_mult_new u5(power_512_q, power_1024_q, mult_5121024_q);
pb_mult_new u6(power_2048_q, power_4096_q, mult_20484096_q);

pb_mult_new u7(mult_24_q, mult_816_q, mult_216_q);
pb_mult_new u8(mult_3264_q, mult_128256_q, mult_32256_q);
pb_mult_new u9(mult_5121024_q, mult_20484096_q, mult_5124096_q);

pb_mult_new u10(mult_216_q, mult_32256_q, mult_2256_q);
pb_mult_new u11(mult_2256_q, mult_5124096_q, b);

//Generate power_i_q
Square u12(a,power_2_q);
Square u13(power_2_q,power_4_q);
Square u14(power_4_q,power_8_q);
Square u15(power_8_q,power_16_q);
Square u16(power_16_q,power_32_q);
Square u17(power_32_q,power_64_q);
Square u18(power_64_q,power_128_q);
Square u19(power_128_q,power_256_q);
Square u20(power_256_q,power_512_q);
Square u21(power_512_q,power_1024_q);
Square u22(power_1024_q,power_2048_q);
Square u23(power_2048_q,power_4096_q);

endmodule //End of the module
