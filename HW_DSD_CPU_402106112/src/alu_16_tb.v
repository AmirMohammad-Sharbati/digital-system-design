module alu_16_tb ();
    localparam CLK_PERIOD = 2;
    
    reg clk, reset, start;
    reg [2:0] opcode;
    reg signed [15:0] A, B;
    wire signed [15:0] result;
    wire done;

    integer i, j;
    wire signed [15:0] add_exp = A + B;
    wire signed [15:0] sub_exp = A - B;
    wire signed [15:0] mul_exp = A * B;
    wire signed [15:0] div_exp = (B !== 0) ? A / B : 0; // I suppose that if the divisor is zero, so the result will be zero :)

    reg error_flag;

    alu_16 alu_inst (clk, reset, start, opcode, A, B, result, done);

    always #(CLK_PERIOD/2) clk = ~clk;

    initial begin
        $dumpfile("alu_16.vcd");
        $dumpvars(0, alu_16_tb);

        clk = 0;
        error_flag = 0;
        reset = 1;
        #CLK_PERIOD;
        reset = 0;
        #CLK_PERIOD;

        for (i = -32768; i < 32768; i = i + 814) begin
            for (j = -32768; j < 32768; j = j + 512) begin
                A = i; B = j;

                opcode = 3'b000;
                start = 1;
                #CLK_PERIOD;
                start = 0;
                wait (done);
                if (result !== add_exp) begin
                    error_flag = 1;
                    $display ("Error: A = %d, B = %d, result = %d , add_exp = %d", A, B, result, add_exp);
                end
                #CLK_PERIOD;

                opcode = 3'b001;
                start = 1;
                #CLK_PERIOD;
                start = 0;
                wait (done);
                if (result !== sub_exp) begin
                    error_flag = 1;
                    $display ("Error: A = %d, B = %d, result = %d , sub_exp = %d", A, B, result, sub_exp);
                end
                #CLK_PERIOD;

                opcode = 3'b010;
                start = 1;
                #CLK_PERIOD;
                start = 0;
                wait (done);
                if (result !== mul_exp) begin
                    error_flag = 1;
                    $display ("Error: A = %d, B = %d, result = %d , mul_exp = %d", A, B, result, mul_exp);
                end
                #CLK_PERIOD;

                opcode = 3'b011;
                start = 1;
                #CLK_PERIOD;
                start = 0;
                wait (done);
                if (result !== div_exp) begin
                    error_flag = 1;
                    $display ("Error: A = %d, B = %d, result = %d , div_exp = %d", A, B, result, div_exp);
                end
                #CLK_PERIOD;
                
            end
        end

        if (error_flag) 
            $display ("ERORORORROORRROROR");
        else $display ("-+*/=-+/*===== Great, perfect ALU :) =====-+*/=-+/*="); // It tooks less than 4 seconds to complete test

        $finish;
        
    end

endmodule