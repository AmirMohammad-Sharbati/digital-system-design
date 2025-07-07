module mul_16_tb ();
    reg signed [15:0] A, B;
    wire signed [15:0] result;

    karatsuba_mul_16 mul (A, B, result);

    wire signed [15:0] exp;
    assign exp = A*B;
    initial begin
        $dumpfile("mul.vcd");
        $dumpvars(0, mul_16_tb);
        $monitor("A: %d, B:%d, result:%d, expected:%d", A, B, result, exp);

        A = 16'sd1;  B = -16'sd32678;  #10;
        A = -16'sd15; B = 16'sd127;   #10;
        A = 16'sd100; B = -16'sd5;  #10;
        A = -16'sd25; B = -16'sd4;  #10;
        A = 16'sd0;   B = 16'sd1234;#10;
        // $display("%d\t%d\t%d\t\t%d", A, B, A*B, result);
        A = 16'sd32767; B = 16'sd2; #10;
    end
endmodule