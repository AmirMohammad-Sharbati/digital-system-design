module delay;

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

    // TRISTATE BUFFER
    parameter tri_min_rise = 5;
    parameter tri_typ_rise = 6;
    parameter tri_max_rise = 7;

    parameter tri_min_fall = 4;
    parameter tri_typ_fall = 5;
    parameter tri_max_fall = 6;

    parameter tri_min_turnoff = 4;
    parameter tri_typ_turnoff = 5;
    parameter tri_max_turnoff = 6;

endmodule
