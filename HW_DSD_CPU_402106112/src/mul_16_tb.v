module mul_16_tb ();
    reg clk, start, reset;
    reg signed [15:0] A, B;
    wire signed [15:0] result;
    wire done;

    karatsuba_mul_16 mul (clk, reset, start, A, B, result, done);

    always #1 clk = ~clk; 
    wire signed [15:0] exp;
    assign exp = A*B;
    reg error_flag;
    integer i, j;

    initial begin
        $dumpfile("mul.vcd");
        $dumpvars(0, mul_16_tb);

        error_flag = 0;

        clk = 0;
        reset = 1;
        start = 0;
        @(posedge clk);
        reset = 0;

        for (i = -32678; i < 32678; i = i + 411) begin 
            for (j = -32678; j < 32678; j = j + 281) begin
                A = i; 
                B = j; 

                start = 1;
                @(posedge clk);
                start = 0;

                // Wait for 'done' signal
                wait (done);
                @(posedge clk); // small delay after done

                if (result !== exp) begin
                    $display("Error: A = %d , B = %d , exp = %d , result = %d ", A, B, exp, result);
                    error_flag = 1;
                end 
            end
        end

        if (error_flag == 1) $display ("Errororrororororororor");
        else $display (" ====== Fortunately, the MUL code has no errors. ======"); // It tooks about 6 seconds
        
        $finish;
    end
endmodule


