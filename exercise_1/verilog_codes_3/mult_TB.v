`timescale 1ns/1ps

module mult_TB();
	reg signed[7:0]x, y;
    wire signed[15:0] p;
    
    reg signed [15:0] expected;
    integer i, j, errors;

    mult mlt (.p(p), .x(x), .y(y));

    initial
    begin
        $dumpfile("multiplier.vcd");
        $dumpvars(0,mult_TB);

        errors = 0;

        // Loop through a range of signed values
        for (i = -128; i <= 127; i = i + 1) begin
            for (j = -128; j <= 127; j = j + 1) begin
                x = i;
                y = j;
                expected = x * y;
                #1; // Wait for result to propagate

                if (p !== expected) begin
                    $display("ERROR: x=%d, y=%d (%b) --> Expected=%d, Got=%d", x, y, y, expected, p);
                    errors = errors + 1;
                end
            end
        end

        $display("Test finished with %0d errors.", errors);

        $finish();
    end
endmodule