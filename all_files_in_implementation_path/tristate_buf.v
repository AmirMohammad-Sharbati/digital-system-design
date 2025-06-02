module tristate_buf #(parameter N = 8)( // 8 is default value of N, can be overriden
	input wire [N-1:0] data_in,	// Data to send to bus
	input wire oe,	// Output enable (1 -> drive bus)
	inout wire [N-1:0] bi_data		// Shared bus 
);
	
	// If oe is 1, drive the bus with data_in. Else output is Z (high-impedance)
	assign  bi_data = oe ? data_in : {N{1'bz}};

endmodule
