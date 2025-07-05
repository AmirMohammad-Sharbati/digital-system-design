module shift_and_add_mul_8 (input signed [7:0] A, B, output signed[15:0] result);
    reg signed [15:0] product, A_shift;
    reg signed [7:0] B_shift;
    integer i;

    always @(*) begin
        product = 16'b0;
        A_shift = A;
        B_shift = B;

        for (i=0; i<8; i = i+1) begin
            if (B_shift[0] == 1'b1) 
                product = product + A_shift;
            A_shift = A_shift <<< 1; // arithmetic shift
            B_shift = B_shift >>> 1;
        end
    end

    assign result = product;
endmodule


module karatsuba_mul_16 (input signed [15:0] A, B, output signed [15:0] result);
    wire signed [15:0] z0, z1, z2, z3;
    
    wire signed [7:0] A_H = A[15:8];
    wire signed [7:0] A_L = A[7:0];
    wire signed [7:0] B_H = B[15:8];
    wire signed [7:0] B_L = B[7:0];

    shift_and_add_mul_8 mul1 (A_L, B_L, z0);
    shift_and_add_mul_8 mul2 (A_H, B_H, z2);
    
    shift_and_add_mul_8 mul3 (A_H + A_L, B_H + B_L, z3);
    assign z1 = z3 - (z0 + z2);

    assign result = (z2 << 16) + (z1 << 8) + z0;
endmodule