module pb_mult_new(a,b,c);
input [12:0] a,b; //Inputs
output [12:0] c; //Output
wire [12:0] a,b;
wire [12:0] c;

//The first two vectors are the basis vectors needed to generate all the other vectors by means of rewiring optimization
wire [12:0] base,base1,vect0,vect1,vect2,vect3,vect4,vect5,vect6,vect7,vect8,vect9,vect10,vect11,vect12;
assign base   = {a[1] ^ a[10] ^ a[12] ^ a[2],a[11] ^ a[2] ^ a[3],a[12] ^ a[3] ^ a[4],a[4] ^ a[5],a[5] ^ a[6],a[6] ^ a[7],a[7] ^ a[8],a[8] ^ a[9],a[10] ^ a[9],a[10] ^ a[11],a[11] ^ a[12],a[0] ^ a[12],a[1]};
assign base1  = {base[9:0],a[2],a[3]^a[0],a[1]^a[4]};
assign vect4  = base ^ base1;
assign vect0  = {vect4[3:0],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[0]};
assign vect1  = base[12:0];
assign vect2  = {base[11:0],a[2]};
assign vect3  = vect0 ^ {base[10],base1[12:1]};
assign vect5  = {vect4[11:0],a[5]};
assign vect6  = {vect4[10:0],a[5],a[6]};
assign vect7  = {vect4[9:0],a[5],a[6],a[7]};
assign vect8  = {vect4[8:0],a[5],a[6],a[7],a[8]};
assign vect9  = {vect4[7:0],a[5],a[6],a[7],a[8],a[9]};
assign vect10 = {vect4[6:0],a[5],a[6],a[7],a[8],a[9],a[10]};
assign vect11 = {vect4[5:0],a[5],a[6],a[7],a[8],a[9],a[10],a[11]};
assign vect12 = {vect4[4:0],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12]};

//Pass the results to a logic function and_add which computes the bitwise AND of vect(i) with c(i) and then adds them upp
//modulo 2
and_add u0(vect0,b,c[0]);
and_add u1(vect1,b,c[1]);
and_add u2(vect2,b,c[2]);
and_add u3(vect3,b,c[3]);
and_add u4(vect4,b,c[4]);
and_add u5(vect5,b,c[5]);
and_add u6(vect6,b,c[6]);
and_add u7(vect7,b,c[7]);
and_add u8(vect8,b,c[8]);
and_add u9(vect9,b,c[9]);
and_add u10(vect10,b,c[10]);
and_add u11(vect11,b,c[11]);
and_add u12(vect12,b,c[12]);

endmodule // end of the module
