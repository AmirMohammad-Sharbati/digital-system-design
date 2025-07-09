module register_file_tb ();
    localparam CLK_PERIOD = 2;

    reg clk, reset, write_enable;
    reg [1:0] write_reg_num, read_reg_1_num, read_reg_2_num;
    reg signed [15:0] write_data;
    wire signed [15:0] read_data_1, read_data_2;

    register_file rf (clk, reset, write_enable, write_reg_num,
        read_reg_1_num, read_reg_2_num, write_data, read_data_1, read_data_2);

    always #(CLK_PERIOD/2) clk = ~clk;

    initial begin
        $dumpfile("register_file.vcd");
        $dumpvars(0, register_file_tb);

        clk = 0;
        reset = 1;
        write_enable = 0;
        write_reg_num = 0;
        write_data = -1404;

        @(posedge clk); // writing on posedge
        reset = 0;
        write_enable = 1;
        #CLK_PERIOD;

        // Write to registers x0 to x3
        repeat (3) begin // This is nice syntax. It is equal to for (i = 0; i < 4; i = i + 1)
            write_reg_num = write_reg_num + 1;
            write_data = write_data + 1000;
            #CLK_PERIOD;
        end

        write_enable = 0;

        read_reg_1_num = 1;
        read_reg_2_num = 2;
        #CLK_PERIOD;
        $display("Read x1 = %d (exp -404), x2 = %d (exp 596)", read_data_1, read_data_2);

        read_reg_1_num = 3;
        read_reg_2_num = 0;
        #CLK_PERIOD;
        $display("Read x3 = %d (exp 1596), x0 = %d (exp -1404)", read_data_1, read_data_2);

        @(posedge clk); // Writing on posedge (we can also use #CLK_PERIOD;)
        write_enable = 1;
        write_reg_num = 1;
        write_data = 4321;

        #CLK_PERIOD
        write_enable = 0;
        read_reg_2_num = 1;
        #CLK_PERIOD;
        $display("Read x3 = %d (exp 1596), x1 = %d (exp 4321)", read_data_1, read_data_2);

        @(posedge clk); // In this part I can also use #(CLK_PERIOD/2) to change registers on posedge (or wait 2*CLK_PERIOD after reset = 1)
        reset = 1;
        #CLK_PERIOD;
        $display("Read x3 = %d (exp 0), x1 = %d (exp 0)", read_data_1, read_data_2);
        
        $finish;
    end

endmodule