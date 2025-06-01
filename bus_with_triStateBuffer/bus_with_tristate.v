module bus_with_tristate #(parameter N = 8)(
    input wire clk, rst,

    // device1 and device2 interfaces
    input wire [N-1:0] data_in_1, data_in_2,  // what device writes on bus
    input wire req1, req2,			              // device wants to drive
    output wire[N-1:0] data_out_1, data_out_2 // what device reads from bus
);

    // TRISTATE BUFFER DELAYS:
    parameter tri_min_rise = 5;
    parameter tri_typ_rise = 6;
    parameter tri_max_rise = 7;

    parameter tri_min_fall = 4;
    parameter tri_typ_fall = 5;
    parameter tri_max_fall = 6;

    parameter tri_min_turnoff = 4;
    parameter tri_typ_turnoff = 5;
    parameter tri_max_turnoff = 6;

    wire [N-1:0] bi_data;
    wire         g1, g2;

    // Instantiate controller
    bus_controller controller (.clk(clk), .rst(rst), .req1(req1), .req2(req2), .grant1(g1), .grant2(g2));

    // Device 1’s tri‐state driver
    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin : ts_buf_gen_1
            bufif1 #(tri_max_rise: tri_typ_rise : tri_min_rise,
                    tri_max_fall:tri_typ_fall : tri_min_fall,
                    tri_max_turnoff: tri_typ_turnoff : tri_min_turnoff) 
                    ts_buffer1 (bi_data[i], data_in_1[i], g1);
        end
    endgenerate

    // Device 2’s tri‐state driver
    generate
        for (i = 0; i < N; i = i + 1) begin : ts_buf_gen_2
            bufif1 #(tri_max_rise: tri_typ_rise : tri_min_rise,
                    tri_max_fall: ri_typ_fall : tri_min_fall,
                    tri_max_turnoff: tri_typ_turnoff : tri_min_turnoff) 
                    ts_buffer2 (bi_data[i], data_in_2[i], g2);
        end
    endgenerate

    // Devices “read” the bus when another device is driving
    assign data_out_1 = g2 ? bi_data : data_out_1;
    assign data_out_2 = g1 ? bi_data : data_out_2;
endmodule
