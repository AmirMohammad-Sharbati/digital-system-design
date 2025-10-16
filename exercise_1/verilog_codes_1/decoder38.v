module decoder38(input [2:0] A, output [7:0]Q);
	wire [3:0] QQ;
	decoder24 deco(A[1:0], QQ);
	assign Q = A[2] ? {QQ, 4'b0000} : {4'b0000, QQ};
endmodule