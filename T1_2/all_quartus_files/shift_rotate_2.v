module shift_rotate_2 (input CLK, SET, CLR, Sr_En, In, 
							output[3:0] q);
	wire shift_in = (Sr_En & In) | (~Sr_En & ~q[3]);	 
	wire [3:0] d = { q[2], q[1], q[0], shift_in};

	SR_FF ff3 (.S(d[0]), .R(~d[0]), .CLK(CLK), .SET(SET), .CLR(CLR), .Q(q[0]), .Qn());
	SR_FF ff0 (.S(d[0]), .R(~d[0]), .CLK(CLK), .SET(SET), .CLR(CLR), .Q(q[1]), .Qn());
  	SR_FF ff1 (.S(d[1]), .R(~d[1]), .CLK(CLK), .SET(SET), .CLR(CLR), .Q(q[2]), .Qn());
  	SR_FF ff2 (.S(d[2]), .R(~d[2]), .CLK(CLK), .SET(SET), .CLR(CLR), .Q(q[3]), .Qn());

endmodule



