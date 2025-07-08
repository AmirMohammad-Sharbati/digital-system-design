module div_16 (input clk, reset, start, signed [15:0] dividend, divisor, 
               output reg done, signed [15:0] quotient, remainder);
    
    reg [4:0] counter;
    reg [15:0] abs_dividend, abs_divisor;
    reg sign_q, sign_r;
    reg start_calc_flag;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            quotient <= 0;
            remainder <= 0;
            done <= 0;
            count <= 0;
        end else if (start) begin
            done <= 0;
            count <= 0;
            // These are for negative numbers
            abs_dividend <= (dividend[15]) ? -dividend : dividend;
            abs_divisor <= (divisor[15]) ? -divisor : divisor;
            sign_q <= dividend[15] ^ divisor[15];
            sign_r <= dividend[15];
            
            start <= 0;
            start_calc_flag <= 1;
        end else if (start_calc_flag) begin
            if (counter == 16) begin
                done <= 1'b1;
                start_calc_flag <= 0;
                quotient <= sign_q ? quotient : -quotient;
                remainder <= sign_r ? remainder : -remainder;
            end else begin
            remainder = remainder << 1;
            remainder[0] = abs_dividend[counter];
            remainder = remainder - abs_divisor;
            quotient << 1;
            if (remainder < 0) begin
                quotient[0] = 0;
                remainder = remainder + abs_divisor;
            end else quotient[0] = 1;

            counter = counter + 1;
            end
            
        end
    end
endmodule