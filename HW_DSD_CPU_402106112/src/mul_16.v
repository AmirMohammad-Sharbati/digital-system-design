module shift_and_add_mul_8 (
    input clk, reset, start, input [7:0] A, B, 
    output reg [15:0] result , output reg done
);
    reg [3:0] counter;
    reg [15:0] product, A_shift;
    reg [7:0] B_shift;
    reg start_calc_flag;

    always @(posedge clk, posedge reset) begin
        if (reset) begin
            counter <= 0;
            result <= 0;
            done <= 0;
            product <= 0;
            start_calc_flag <= 0;
        end else if (start && !start_calc_flag) begin
            counter <= 0;
            result <= 0;
            done <= 0;
            product <= 0;
            A_shift <= A;
            B_shift <= B;
            start_calc_flag <= 1;
        end else if (start_calc_flag) begin
            if (B_shift[0])
                product = product + A_shift;
            A_shift = A_shift <<< 1; // arithmetic shift
            B_shift = B_shift >>> 1;
            counter <= counter + 1;
            if (counter == 7) begin
                done <= 1;
                start_calc_flag <= 0;
                result <= product;
            end
        end
    end
endmodule


module karatsuba_mul_16 (
    input clk, reset, start,
    input signed [15:0] A, B, 
    output reg signed [15:0] result,
    output reg done
);
    
    wire [15:0] z0, z2, z3;
    wire z0_done, z1_done, z2_done;
    reg active;

    shift_and_add_mul_8 z0_unit (clk, reset, start, A[7:0], B[7:0], z0, z0_done);
    shift_and_add_mul_8 z2_unit (clk, reset, start, A[15:8], B[15:8], z2, z2_done);
    shift_and_add_mul_8 z1_unit (clk, reset, start, A[15:8] + A[7:0], B[15:8] + B[7:0], z3, z1_done);
    
    always @(posedge clk, posedge reset) begin
        if (reset) begin
            done <= 0;
            result <= 0;
            active <= 0;
        end else if (start) begin
            done <= 0;
            result <= 0;
            active <= 1;
        end else if (active && z0_done && z1_done && z2_done) begin
            result <= (z2 <<< 16) + ((z3 - (z0 + z2)) <<< 8) + z0;
            done <= 1;
            active <= 0;
        end else done <= 0;
    end
endmodule