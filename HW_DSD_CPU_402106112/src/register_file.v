module register_file (
    input clk, reset, 
    input write_enable, 
    input [1:0] write_reg_num, read_reg_1_num, read_reg_2_num,
    input [15:0] write_data,
    output reg [15:0] read_data_1, read_data_2
);

    reg [15:0] registers[3:0];

    // Write is done on rising edge of clock
    always @(posedge clk, posedge reset) begin
        if (reset) begin
            for (i = 0; i < 4; i = i + 1)
                registers[i] <= 16'd0;
        end else if (write_enable) begin
            registers[write_reg_num] <= write_data;     
        end
    end

    // Read is done on falling edge of clock
    always @(negedge clk) begin
        read_data_1 <= registers[read_reg_1_num];
        read_data_2 <= registers[read_reg_2_num];
    end

endmodule