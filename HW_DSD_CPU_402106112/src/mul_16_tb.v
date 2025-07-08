module mul_16_tb ();
    reg signed [15:0] A, B;
    wire signed [15:0] result;

    karatsuba_mul_16 mul (A, B, result);

    wire signed [15:0] exp;
    assign exp = A*B;
    reg error_flag;
    integer i, j;

    initial begin
        $dumpfile("mul.vcd");
        $dumpvars(0, mul_16_tb);

        error_flag = 0;

        for (i = -32678; i < 32678; i = i + 111) begin 
            for (j = -32678; j < 32678; j = j + 285) begin
                A = i; 
                B = j; 
                #1;
                if (result !== exp) begin
                    $display("Error: A = %d , B = %d , exp = %d , result = %d ", A, B, exp, result);
                    error_flag = 1;
                end
            end
        end

        if (error_flag == 1) $display ("Errororrororororororor");
        else $display (" ====== Fortunately, the MUL code has no errors. ======"); // It tooks about 7 seconds
        $finish;
    end
endmodule


