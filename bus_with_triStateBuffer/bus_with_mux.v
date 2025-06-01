module bus_wit_mux #(parameter N = 8)(
    input wire [N-1:0] data_in_1, data_in_2,
    input wire clk, select,               // 0: device 1 drives; 1: device 2 drives
    output wire [N-1:0] bus,       // the shared lines
    output wire [N-1:0] data_out_1, data_out_2// feedback to devices 
);
    // simple 2‑to‑1 multiplexer
    wire not_select;
    not #(delay.not_max_rise: delay.not_typ_rise: delay.not_min_rise,
          delay.not_max_fall: delay.not_typ_fall: delay.not_min_fall) (not_select, select);

    genvar i;
    generate
      for (i = 0; i < N; i = i + 1) begin : mux_bits
        wire a1, a2;
        and #(delay.and_max_rise: delay.and_typ_rise: delay.and_min_rise,
              delay.and_max_fall: delay.and_typ_fall: delay.and_min_fall) (a1, not_select, data_in_1[i]);
        and #( delay.and_max_rise: delay.and_typ_rise: delay.and_min_rise,
              delay.and_max_fall: delay.and_typ_fall: delay.and_min_fall) (a2, select, data_in_2[i]);
        or  #(delay.or_max_rise: delay.or_typ_rise: delay.or_min_rise,
              delay.or_max_fall: delay.or_typ_fall: delay.or_min_fall) (bus[i], a1, a2);
      end
    endgenerate

    // every device can read the bus
    assign data_out_1 = (select == 1'b1) ? bus : data_out_1;
    assign data_out_2 = (select == 1'b0) ? bus : data_out_2;

endmodule
