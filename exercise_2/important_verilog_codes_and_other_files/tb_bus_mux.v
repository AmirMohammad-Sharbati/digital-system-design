module tb_bus_mux;
    parameter N = 8;
    reg clk, select;
    reg [N-1:0] data_in_1, data_in_2;
    wire [N-1:0] bus;
    wire [N-1:0] dout1, dout2;

    bus_wit_mux #(N) bus_mux(
        .data_in_1(data_in_1), .data_in_2(data_in_2),
        .clk(clk), .select(select),
        .bus(bus), .data_out_1(dout1), .data_out_2(dout2)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("bus_mux_wave.vcd"); // For testing with Icarus
        $dumpvars(0, tb_bus_mux); 

        $monitor("t=%0t select=%d bus=%h dout1=%h dout2=%h",
                $time, select, bus_mux.bus, dout1, dout2);

        select = 0; 
        data_in_1 = {{(N-8){1'b0}}, 8'hA2}; 
        data_in_2 = {{(N-8){1'b0}}, 8'h9C};

        #20 select = 1;
        #20 select = 0;
        #20 select = 1;
        data_in_1 = {{(N-8){1'b0}}, 8'h54}; 
        data_in_2 = {{(N-8){1'b0}}, 8'h83};
        #20 select = 0;
        #20 $finish;
    end
endmodule