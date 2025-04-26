module SR_FF(input wire S, R, clk, SET, CLR,
				output reg Q, Qn);
	always @(negedge clk, posedge SET, posedge CLR) begin
		if (CLR) begin
			Q <= 0;
			Qn <= 1;
		end else if(SET) begin
			Q <= 1;
			Qn <= 0;
		end else if (S && ~R) begin
			Q <= 1;
			Qn <= 0;
		end else if (~S && R) begin
			Q <= 0;
			Qn <= 1;
		end else if (S && R) begin
			Q <= 1'bx; // Undefined behavior when both S and R are 1
			Qn <= 1'bx;
		end
      // If both S=0 and R=0, keep previous state
	end
endmodule
