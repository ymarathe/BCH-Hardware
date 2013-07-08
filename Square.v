/*
Implementation of a Squaring block in GF(2^13).
Takes in a field element in PB representation and outputs the square of the element in PB representation.
*/
module Square(a,b);
input [12:0] a; //Input
output [12:0] b; //Output
wire [12:0] a;
wire [12:0] b;

//Perform suitable operations to compute individual bits.
//Defined by the Primitive polynomial of the field.
assign b[12]   = a[6]^a[11]^a[12];
assign b[11] 	= a[10]^a[12];
assign b[10] 	= a[5]^a[10]^a[11];
assign b[9] 	= a[9]^a[11];
assign b[8] 	= a[4]^a[9]^a[10];
assign b[7] 	= a[8]^a[10];
assign b[6] 	= a[3]^a[8]^a[9]^a[12];
assign b[5] 	= a[7]^a[9];
assign b[4] 	= a[2]^a[7]^a[8]^a[11]^a[12];
assign b[3] 	= a[8]^a[11]^a[12];
assign b[2] 	= a[1]^a[7];
assign b[1] 	= a[7]^a[11]^a[12];
assign b[0] 	= a[0]^a[11];

endmodule //End of the module
