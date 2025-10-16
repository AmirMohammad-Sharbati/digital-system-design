module SR_FF(input wire S, R, CLK, SET, CLR,
				output reg Q, output wire Qn);
	always @(negedge CLK, posedge SET, posedge CLR) begin
		if (CLR) 
			Q <= 0;
		else if(SET)
			Q <= 1;
		else if (S && ~R)
			Q <= 1;
		else if (~S && R)
			Q <= 0;
		else if (S && R)
			Q <= 1'bx; // Undefined behavior when both S and R are 1
      // If both S=0 and R=0, keep previous state
	end
	
	 assign Qn = ~Q;
endmodule
