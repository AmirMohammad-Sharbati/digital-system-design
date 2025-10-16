module bus_wit_mux #(parameter N = 8)(
    input wire [N-1:0] data_in_1, data_in_2,
    input wire clk, select,               // 0: device 1 drives; 1: device 2 drives
    output wire [N-1:0] bus,       // the shared lines
    output wire [N-1:0] data_out_1, data_out_2// feedback to devices 
);

    // NOT gate
    parameter not_min_rise = 2;
    parameter not_typ_rise = 3;
    parameter not_max_rise = 4;

    parameter not_min_fall = 1;
    parameter not_typ_fall = 2;
    parameter not_max_fall = 3;

    // AND gate
    parameter and_min_rise = 5;
    parameter and_typ_rise = 6;
    parameter and_max_rise = 7;

    parameter and_min_fall = 4;
    parameter and_typ_fall = 5;
    parameter and_max_fall = 6;

    // OR gate
    parameter or_min_rise = 4;
    parameter or_typ_rise = 5;
    parameter or_max_rise = 6;

    parameter or_min_fall = 3;
    parameter or_typ_fall = 4;
    parameter or_max_fall = 5;


    reg [N-1:0] data_out_1_reg, data_out_2_reg;
    // simple 2‑to‑1 multiplexer
    wire not_select;
    not #(not_max_rise: not_typ_rise: not_min_rise,
          not_max_fall: not_typ_fall: not_min_fall) (not_select, select);

    genvar i;
    generate
      for (i = 0; i < N; i = i + 1) begin : mux_bits
        wire a1, a2;
        and #(and_max_rise: and_typ_rise: and_min_rise,
              and_max_fall: and_typ_fall: and_min_fall) (a1, not_select, data_in_1[i]);
        and #(and_max_rise: and_typ_rise: and_min_rise,
              and_max_fall: and_typ_fall: and_min_fall) (a2, select, data_in_2[i]);
        or  #(or_max_rise: or_typ_rise: or_min_rise,
              or_max_fall: or_typ_fall: or_min_fall) (bus[i], a1, a2);
      end
    endgenerate

    // Devices “read” the bus when another device is driving
    always @(bus) begin
      if (select == 1'b1) data_out_1_reg <= bus;
    end

    always @(bus) begin
      if (select == 1'b0) data_out_2_reg <= bus;
    end

    assign data_out_1 = data_out_1_reg;
    assign data_out_2 = data_out_2_reg;

endmodule
