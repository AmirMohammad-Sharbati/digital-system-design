module tb_two_device_bus;
  parameter N = 8;
  reg         clk, rst;
  reg         req1, req2;
  reg  [N-1:0] din1, din2;
  wire [N-1:0] dout1, dout2;
  wire        g1, g2;

  two_device_bus_top #(.N(N)) dut (
    .clk(clk), .rst(rst),
    .data_in_1(din1), .req1(req1), .data_out_1(dout1),
    .data_in_2(din2), .req2(req2), .data_out_2(dout2),
    .grant1(g1), .grant2(g2)
  );

  // simple clock
  initial clk = 0;
  always #5 clk = ~clk;

  initial begin
    rst = 1; req1 = 0; req2 = 0; din1 = 8'hAA; din2 = 8'h55;
    #12 rst = 0;

    // Device 1 drives
    #10 req1 = 1; req2 = 0;
    #20 req1 = 0;
    // Bus should read 0xAA at both dout1 and dout2

    // Device 2 drives
    #10 req2 = 1;
    #20 req2 = 0;
    // Bus should read 0x55 now
    #10 $finish;
  end

  initial begin
    $monitor("t=%0t g1=%b g2=%b bus=%h dout1=%h dout2=%h",
             $time, g1, g2, dut.bi_data, dout1, dout2);
  end
endmodule
