module div_16_tb ();
    reg clk, start, reset;
    reg signed [15:0] dividend, divisor;
    wire signed [15:0] quotient, remainder;
    wire done;

    div_16 divide (clk, reset, start, dividend, divisor, quotient, remainder, done);

    always #1 clk = ~clk;

    wire signed [15:0] exp_remainder, exp_quotient;
    assign exp_remainder = dividend % divisor;
    assign exp_quotient = dividend / divisor;
    reg error_flag;
    integer i, j;
    
    initial begin
        $dumpfile("div.vcd");
        $dumpvars(0, div_16_tb);

        error_flag = 0;
        
        clk = 0;
        reset = 1;
        start = 0;
        @(posedge clk);
        reset = 0;

        for (i = -32768; i < 32768; i = i + 337) begin 
            for (j = -32768; j < 32768; j = j + 208) begin
                dividend = i; 
                divisor = j;

                start = 1;
                @(posedge clk);
                start = 0;

                // Wait for 'done' signal
                wait (done);
                @(posedge clk); // small delay after done

                if (quotient !== exp_quotient || remainder !== exp_remainder) begin
                    $display("Error: dividend = %d , divisor = %d , exp_r = %d , r = %d , exp_q = %d, q = %d"
                        , dividend, divisor, exp_remainder, remainder, exp_quotient, quotient);
                    error_flag = 1;
                end
                    
            end
        end

        if (error_flag == 1) $display ("Errororrororororororor");
        else $display (" ====== Good, the DIV code has no errors. ======"); // It tooks about 5 seconds        

        $finish;

    end

endmodule