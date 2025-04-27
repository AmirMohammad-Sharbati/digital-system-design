module shift_rotate_2 (input CLK, SET, CLR, Sr_En, In, 
							output[3:0] q);
	wire shift_in = (Sr_En & In) | (~Sr_En & ~q[3]);	

	SR_FF ff0 (.S(shift_in), .R(~shift_in), .CLK(CLK), .SET(SET), .CLR(CLR), .Q(q[0]), .Qn());
    SR_FF ff1 (.S(q[0]), .R(~q[0]), .CLK(CLK), .SET(SET), .CLR(CLR), .Q(q[1]), .Qn());
    SR_FF ff2 (.S(q[1]), .R(~q[1]), .CLK(CLK), .SET(SET), .CLR(CLR), .Q(q[2]), .Qn());
    SR_FF ff3 (.S(q[2]), .R(~q[2]), .CLK(CLK), .SET(SET), .CLR(CLR), .Q(q[3]), .Qn());

endmodule
