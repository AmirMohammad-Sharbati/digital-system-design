module decoder38_test ();
	reg[2:0] A;
	wire[7:0] Q;
	decoder38 deco(A, Q);
	
	initial
	begin
		$dumpfile("deco38_wave.vcd"); // These two lines are for seeing waveform
  		$dumpvars(0, decoder38_test);
		
		$monitor("A=%b -> Q=%b", A, Q);
		A = 3'b000;
		#10 A = 3'b001;
		#10 A = 3'b010;
		#10 A = 3'b011;
		#10 A = 3'b100;
		#10 A = 3'b101;
		#10 A = 3'b110;
		#10 A = 3'b111;
		#10 $finish();
	end
endmodule