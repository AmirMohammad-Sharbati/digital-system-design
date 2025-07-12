module alu_16 (
    input clk, reset, start,
    input [2:0] opcode,
    input signed [15:0] A, B,
    output reg signed [15:0] result,
    output reg done
);

    // Internal states for multi-cycle operations
    localparam IDLE = 0, MUL_WAIT = 1, DIV_WAIT = 2, DONE = 3;
    reg [1:0] state;

    // add/sub unit 
    wire [15:0] add_sub_result;
    wire c_out;
    // If operation is subtract, we use two's complement of second operator
    wire signed [15:0] b_adder = (opcode == 3'b001) ? ~B + 1: B;
    csa_16 add_sub (A, b_adder, 0, add_sub_result, c_out);

    // multification unit
    reg mul_start;
    wire [15:0] mul_result;
    wire mul_done;
    karatsuba_mul_16 mul (clk, reset, mul_start, A, B, mul_result, mul_done);

    // division unit
    reg div_start;
    wire [15:0] div_quotient, div_remainder;
    wire div_done;
    div_16 div (clk, reset, start, A, B, quotient, remainder, div_done);

    // CONTROL LOGIC
    always @(posedge clk, posedge reset) begin
        if (reset) begin
            done <= 0;
            result <= 0;
            state <= IDLE;
            mul_start <= 0;
            div_start <= 0;
        end else begin
            case(state)
                IDLE: begin
                    
                end

                MUL_WAIT: begin
                    
                end

                DIV_WAIT: begin
                    
                end


            endcase
        end 
    end


endmodule