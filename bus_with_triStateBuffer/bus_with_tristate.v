module bus_with_tristate #(parameter N = 8)(
  input wire clk, rst,

  // device1 and device2 interfaces
  input wire [N-1:0] data_in_1, data_in_2,  // what device writes on bus
  input wire req1, req2,			              // device wants to drive
  output wire[N-1:0] data_out_1, data_out_2// what device reads from bus
);

  wire [N-1:0] bi_data;
  wire         g1, g2;

  // Instantiate controller
  bus_controller controller (.clk(clk), .rst(rst), .req1(req1), .req2(req2), .grant1(g1), .grant2(g2));

  // Device 1’s tri‐state driver
  tristate_buf #(.N(N)) ts_buffer1 (.data_in (data_in_1), .oe (g1), .bi_data (bi_data));

  // Device 2’s tri‐state driver
  tristate_buf #(.N(N)) ts_buffer2 (.data_in (data_in_2), .oe (g2), .bi_data (bi_data));

  // Devices “read” the bus when another device is driving
  assign data_out_1 = g2 ? bi_data : data_out_1;
  assign data_out_2 = g1 ? bi_data : data_out_2;
endmodule
