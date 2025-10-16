module decoder24_test();
	reg [1:0]A;
	wire [3:0]Q;
	decoder24 deco(A, Q);
	initial
	begin
		$dumpfile("deco24_wave.vcd"); // These two lines are for seeing waveform
  		$dumpvars(0, decoder24_test);
		
		$monitor("A=%b -> Q=%b", A, Q);
		A = 2'b00;
		#10 A = 2'b01;
		#10 A = 2'b10;
		#10 A = 2'b11;
		#10 $finish();
	end
endmodule