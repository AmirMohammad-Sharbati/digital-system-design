`timescale 1ns/1ps

module mult_TB_2();
	reg signed [7:0]x;
	reg signed[7:0]y;
	wire signed[15:0] p;

	mult mlt (p, x, y);

	initial
	begin
		$monitor("x = %d, y = %d --> p = %d", x, y, p);

		$dumpfile("multiplier2.vcd");
		$dumpvars(0,mult_TB_2);

		// Correct outputs
		x = 8'd15; y = 8'd7;
		#10 x = 8'd100; y = 8'd83;
		#10 x = -8'd100; y = 8'd83;
		#10 x = 8'd90; y = 8'd38;
		#10 x = 8'd80; y = -8'd71;
		#10 x = 8'd70; y = 8'd105;
		#10 x = -8'd70; y = 8'd105;
		#10 x = 8'd70; y = -8'd105;
		#10 x = -8'd70; y = -8'd105;
		#10 x = -8'd3; y = -8'd13;
		#10 x = 8'd52; y = -8'd41;
		#10 x = -8'd0; y = -8'd26;

		// Wrong outputs -> x = -128 and y has 100 in at least one of its four group of three bits
		#10 $display("\n These are wrong answers:");
		#10 x = -8'd128; y = -8'd66;
		#10 x = -8'd128; y = -8'd114;
		#10 x = -8'd128; y = -8'd50;
		#10 x = -8'd128; y = -8'd121;

		#10 $finish();
	end
endmodule