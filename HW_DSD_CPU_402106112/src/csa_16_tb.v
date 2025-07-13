module csa_16_tb ();
    reg signed [15:0] A, B;
    reg c_in;
    wire signed [15:0] sum;
    wire c_out;

    csa_16 adder (A, B, c_in, sum, c_out);

    reg error_flag;
    integer i,j, k;
    wire signed [16:0] result = {c_out, sum};
    wire signed [16:0] expected = A + B + c_in;

    initial begin
        $dumpfile("csa_16.vcd");
        $dumpvars(0, csa_16_tb);
        error_flag = 0;

        for (i = -32768; i < 32768; i = i + 128) begin
            for (j = -32768; j < 32768; j = j + 274) begin
                for(k = 0; k < 2; k = k + 1) begin
                    c_in = k; A = i; B = j;
                    #1; 
                    if (result !== expected) begin
                        error_flag = 1;
                        $display("A = %d, B = %d, c_in = %d | sum = %d, c_out = %d| expected sum = %d, expeceted c_out = %d",
                                A, B, c_in, sum, c_out, expected[15:0], expected[16]);                        
                    end
                end
            end
        end

        if (error_flag) $display("Erorororororoororrroro");
        else $display(" +-+-+-+-+ Great, code works well +-+-+-+-+"); // It tooks about 5 seconds to complete the test

        $finish;

    end

endmodule