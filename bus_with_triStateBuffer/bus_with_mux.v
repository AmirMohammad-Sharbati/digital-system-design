module bus_wit_mux #(parameter N = 8)(
    input wire [N-1:0] data_in_1, data_in_2,
    input wire clk, sel,               // 0: device 1 drives; 1: device 2 drives
    output wire [N-1:0] bus,       // the shared lines
    output wire [N-1:0] data_out_1, data_out_2// feedback to devices 
);
    // simple 2‑to‑1 multiplexer
    assign bus = (sel == 1'b0) ? data_in_1 : data_in_2;

    // every device can read the bus
    assign data_out_1 = bus;
    assign data_out_2 = bus;

endmodule
