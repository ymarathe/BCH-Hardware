/*
Computes (alpha)^a in GF(2^13).
a is in binary representation, ranging from 0 to 8191.
b is in PB representation.
Executes in 13 clock cycles.
*/

module exponent(a,b,clk,start,done);

//IO, Reg, Wire declarations
input [12:0] a;     //Input
output [12:0] b;    //Output
input clk;          //Clock
input start;        //Start Signal to signal the start of the computation.
output done;        //Done signal to signal the end of the computation.

wire [12:0] a;
wire clk,start;
reg [12:0] b = {13{1'b0}};
reg done = 1'b0;

//State count
reg [3:0]  u_cnt   		= {4{1'b0}};

//Input register to the Squarer
reg [12:0] u_square_ip  = {{11{1'b0}},2'b10};

//Output register to store the product
reg [12:0] u_mult_op		= {{12{1'b0}},1'b1};

//Output register to store the value output by the mux
reg [12:0] u_mux_op  	= {{12{1'b0}},1'b1};

//Input wire to the multiplier
wire [12:0] u_mult_int_q;

//Output wire from the multiplier
wire [12:0] u_mult_op_q;

//Input wire to the multiplier
wire [12:0] u_mult_ip_q;

//Output wire from the Squarer
wire [12:0] u_square_op_q;

//Input wire to the squarer.
wire [12:0] u_square_ip_q;

//State machine
always @(posedge clk) 
begin

/*
If state = 0 and start = 0, indicate that there is no computation by setting done = 0.
Update state.
*/
if(u_cnt==0) begin
done <= 1'b0;
if(start == 1'b1) begin
u_cnt <= u_cnt + 1;
end
end

/*
If state is between 1 and 13, do the following.
1) Make u_mult_op hold the results of previous multiplications
2) Make u_square_ip hold the results of previous squaring.
3) Make u_mux_op hold the results of the output of the multiplexor
5) Change state (Increment)

If state = 13, do the following
1) Set the value of the output to be the current value of u_mult_op register.
2) Change state to state = 0
3) Set the value of u_mult_op and u_mux_op to finite field element '1'
4) Assert the 'done' signal.
*/
else if(u_cnt >=1 & u_cnt<=13) begin
u_mult_op <= u_mult_op_q;
u_mux_op  <= (a[u_cnt-1])? u_square_ip_q: {{12{1'b0}},1'b1};
u_square_ip <= u_square_op_q;
u_cnt <= u_cnt + 1;
if(u_cnt==13) begin
done	<=	1'b1;
b 		<= u_mult_op;
u_cnt <= {4{1'b0}};
u_mult_op <= {{12{1'b0}},1'b1};
u_mux_op  <= {{12{1'b0}},1'b1};
end
end

end

// Assign values in registers to appropriate wires.
assign u_mult_int_q 	= u_mult_op;
assign u_mult_ip_q 	= u_mux_op;
assign u_square_ip_q = u_square_ip;

//Perform appropriate multiplications and Squaring operation
pb_mult_new u3(u_mult_ip_q,u_mult_int_q,u_mult_op_q);
Square u4(u_square_ip_q,u_square_op_q);

endmodule  //End of the module
