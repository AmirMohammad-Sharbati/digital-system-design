module tb_bus_mux;
    parameter N = 8;
    reg clk, select;
    reg [N-1:0] data_in_1, data_in_2;
    wire [N-1:0] bus;
    wire [N-1:0] dout1, dout2;

    bus_wit_mux #(N) bus_mux(
        .data_in_1(data_in_1), .data_in_2(data_in_2),
        .clk(clk), .sel(select),
        .bus(bus), .data_out_1(dout1), .data_out_2(dout2)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("bus_mux_wave.vcd"); // For testing with Icarus
        $dumpvars(0, tb_bus_mux); 

        $monitor("t=%0t bus=%h dout1=%h dout2=%h",
                $time, bus_mux.bus, dout1, dout2);

        #10 select = 0; data_in_1 = 8'hA2; data_in_2 = 8'h9C;
        #10 select = 1;
        #10 select = 0;
        #10 select = 1;
        #10 select = 1; data_in_1 = 8'h54; data_in_2 = 8'h90;
        #10 select = 0;
        #10 $finish;
    end
endmodule