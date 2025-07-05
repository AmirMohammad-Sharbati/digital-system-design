module FA (input a, b, c_in, output sum, c_out);
    xor (sum, a, b, c_in);
    wire c1, c2, c3;
    and (c1, a, b); 
    and (c2, a, c_in); 
    and (c3, b, c_in);
    or (c_out, c1, c2, c3); 
endmodule


module ripple_carry_adder_4 (input [3:0] A, B, input c_in, output [3:0] sum, output c_out);
    wire c1, c2, c3;
    FA f1 (A[0], B[0], c_in, sum[0], c1);
    FA f2 (A[1], B[1], c1, sum[1], c2);
    FA f3 (A[2], B[2], c2, sum[2], c3);
    FA f4 (A[3], B[3], c3, sum[3], c_out);
endmodule


module mux_21 (input a, b, s, output out);
    wire c1, c2, s_not;
    not (s_not, s);
    and (c1, a, s_not);
    and (c2, b, s);
    or (out, c1, c2);
endmodule 


// This module selects one of two 4 bit vector
module mux_84 (input [3:0] A, B, input select, output [3:0] out);
    genvar i;
    generate
        for (i = 0; i < 4; i = i + 1) 
            mux_21 m(A[i], B[i], select, out[i]);
    endgenerate
endmodule

