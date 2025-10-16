module decoder24 (input [1:0]A, output [3:0]Q);
	assign Q[0] = ~A[0] & ~A[1];
	assign Q[1] = A[0] & ~A[1];
	assign Q[2] = ~A[0] & A[1];
	assign Q[3] = A[0] & A[1];
endmodule