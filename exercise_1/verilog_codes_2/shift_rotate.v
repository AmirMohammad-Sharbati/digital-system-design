module shift_rotate (input CLK, SET, CLR, Sr_En, In, 
							output reg[3:0] q);
	wire shift_in = Sr_En ? In : ~q[3]; // This uses mux for implemenation which is a little different from this ciruit
	// Another approach: shift_in = (Sr_En & In) | (~Sr_En & ~q[3])
	always @(negedge CLK, posedge SET, posedge CLR)
	begin
		if (CLR) q <= 4'b0000;		 // highest priority: clear
		else if(SET) q <= 4'b1111;	 // next: set
		else q <= {q[2:0] , shift_in}; // shift the lower 3 bits up
	end
						
endmodule