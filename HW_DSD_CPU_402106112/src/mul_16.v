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
            if (counter == 8) begin
                done <= 1;
                start_calc_flag <= 0;
                result <= product;
            end
        end else done <= 0;
    end
endmodule


module karatsuba_mul_16 (
    input clk, reset, start,
    input signed [15:0] A, B, 
    output reg signed [15:0] result,
    output reg done
);
    
    reg[2:0] state;
    reg [15:0] z0, z1, z2;

    wire [15:0] partial_result;
    wire mul_done;
    reg mul_start;
    reg [7:0] mul_A, mul_B;

    shift_and_add_mul_8 mul_unit (clk, reset, mul_start, mul_A, mul_B, partial_result, mul_done);
    
    always @(posedge clk, posedge reset) begin
        if(reset) begin
            state <= 0;
            done <= 0;
            result <= 0;
            mul_start <= 0;
        end else begin
            case (state)
                0: begin
                    if (start) begin
                        mul_A <= A[7:0];
                        mul_B <= B[7:0];
                        mul_start <= 1;
                        state <= 1;  // z0
                    end
                end
                1 : begin
                    mul_start <= 0;
                    if (mul_done) begin
                        z0 <= partial_result;
                        mul_A <= A[15:8];
                        mul_B <= B[15:8];
                        mul_start <= 1;
                        state <= 2;  // z2
                    end
                end 

                2: begin
                    mul_start <= 0;
                    if (mul_done) begin
                        z2 <= partial_result;
                        mul_A <= A[15:8] + A[7:0];
                        mul_B <= B[15:8] + B[7:0];
                        mul_start <= 1;
                        state <= 3;  
                    end
                end

                3: begin
                    mul_start <= 0;
                    if (mul_done) begin
                        z1 <= partial_result - (z0 + z2);
                        state <= 4;
                    end
                end
                
                4: begin // Final computation
                    result <= (z2 <<< 16) + (z1 <<< 8) + z0;
                    done <= 1;
                    state <= 5;
                end

                5: begin
                    done <= 0;  // After 1 cycle, it is better to done becomes 0
                    state <= 0;
                end
            endcase
        end
    end
endmodule