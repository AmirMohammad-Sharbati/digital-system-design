module tb_bus_tristate;
  parameter N = 8;
  reg clk, rst;
  reg req1, req2;
  reg  [N-1:0] din1, din2;
  wire [N-1:0] dout1, dout2;

  bus_with_tristate #(N) dut (
    .clk(clk), .rst(rst),
    .data_in_1(din1), .req1(req1), .data_out_1(dout1),
    .data_in_2(din2), .req2(req2), .data_out_2(dout2)
  );

  // simple clock
  initial clk = 0;
  always #5 clk = ~clk;

  initial begin
    $dumpfile("bus_wave.vcd"); // For testing with Icarus
    $dumpvars(0, tb_bus_tristate); 

    $monitor("t=%0t bus=%h dout1=%h dout2=%h",
             $time, dut.bi_data, dout1, dout2);

    rst = 1; req1 = 0; req2 = 0; 
    din1 = {{(N-8){1'b0}}, 8'hAA};
    din2 = {{(N-8){1'b0}}, 8'h55};
    
    #20 rst = 0; req1 = 1;

    #20 req1 = 1; req2 = 0;
    din1 = {{(N-8){1'b0}}, 8'hE5};
   
    #20 req2 = 1; // priority is given to the first

    #20 req1 = 0;
    #20 din2 = 8'h61;
    #20 req1 = 1;
    din1 = {{(N-8){1'b0}}, 8'hcc};

    #20 req2 = 0;
    #20 req1 = 0;

    #20 $finish;
  end
endmodule
