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
input clk,start;    //Clock and Start Signal to signal the start of the computation.
output done;        //Done signal to signal the end of the computation.

wire [12:0] a;
wire clk,start;
reg [12:0] b = {13{1'b0}};
reg done = 1'b0;

reg [3:0]  u_cnt   		= {4{1'b0}};
reg [12:0] u_square_ip  = {{11{1'b0}},2'b10};
reg [12:0] u_mult_op		= {{12{1'b0}},1'b1};
reg [12:0] u_mux_op  	= {{12{1'b0}},1'b1};

wire [12:0] u_mult_int_q;
wire [12:0] u_mult_op_q;
wire [12:0] u_mult_ip_q;
wire [12:0] u_square_op_q;
wire [12:0] u_square_ip_q;

//State machine
always @(posedge clk) 
begin

if(u_cnt==0) begin
done <= 1'b0;
if(start == 1'b1) begin
u_cnt <= u_cnt + 1;
end
end

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

assign u_mult_int_q 	= u_mult_op;
assign u_mult_ip_q 	= u_mux_op;
assign u_square_ip_q = u_square_ip;

pb_mult_new u3(u_mult_ip_q,u_mult_int_q,u_mult_op_q);
Square u4(u_square_ip_q,u_square_op_q);

endmodule  //End of the module
