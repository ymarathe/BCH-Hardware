module inverse(a,b,clk,start,done);
input [12:0] a;           //Input
output [12:0] b;          //Output
input clk;                //Clock
input start;              //Start signal to start the computation
output done;              //Done signal to signal the end of the computation.

wire [12:0] a;
wire clk;
wire start;
reg done=1'b0;
reg [12:0] b ={13{1'b0}};


//Registers to hold the results of Multiplication and Squaring
reg [12:0] u_temp_data1={13{1'b0}},u_temp_data2={13{1'b0}};

//State count
reg [3:0] u_cnt={4{1'b0}};

//Wires to pass the u_temp_data1 and u_temp_data2 registers to the inputs of the multiplier and squarer block, respectively.
wire [12:0] u_temp_data1_q, u_temp_data2_q;

//Output wire from the multiplier
wire [12:0] u_mult_int_value_q;

//Output wire from the squarer
wire [12:0] u_square_int_value_q;

//Computation
always @ (posedge clk)
begin

/*
If state = 0 and start = 0, indicate that there is no computation by setting done = 0.
If state = 0 and start = 1, perform the following initializations.
1) Initialize u_temp_data1 to field element '1'.
2) Initialize u_temp_data2 to square of the field element a.
*/

if(u_cnt==0) begin
done <=1'b0;
if(start==1'b1) begin
u_temp_data1 <= {{12{1'b0}},1'b1};
u_temp_data2 <= {a[6]^a[11]^a[12],a[10]^a[12], a[5]^a[10]^a[11],a[9]^a[11],a[4]^a[9]^a[10],a[8]^a[10],a[3]^a[8]^a[9]^a[12],a[7]^a[9],a[2]^a[7]^a[8]^a[11]^a[12],a[8]^a[11]^a[12],a[1]^a[7],a[7]^a[11]^a[12],a[0]^a[11]};
u_cnt <= u_cnt + 1;
end
end

/*
If state is between 1 and 13, do the following.
1) Make u_temp_data1 hold the results of previous multiplications
2) Make u_temp_data2 hold the results of previous squaring.
3) Change state (Increment)

If state = 13, do the following
1) Set the value of the output to be the current value of u_temp_data1 register.
2) Change state to state = 0
3) Assert the 'done' signal.
*/
else if (u_cnt>=1 & u_cnt <=13) begin
u_temp_data1  <=	u_mult_int_value_q;
u_temp_data2	<=	u_square_int_value_q;
u_cnt <= u_cnt + 1;
if(u_cnt==13) begin
done	<=	1'b1;
b 		<= u_temp_data1;
u_cnt <= {4{1'b0}};
end
end

end

//Update the values of the wires
assign u_temp_data1_q = u_temp_data1;
assign u_temp_data2_q = u_temp_data2;


//Do multiplication and Squaring
pb_mult_new u3(u_temp_data1_q,u_temp_data2_q,u_mult_int_value_q);
Square u4(u_temp_data2_q,u_square_int_value_q);

endmodule //End module
