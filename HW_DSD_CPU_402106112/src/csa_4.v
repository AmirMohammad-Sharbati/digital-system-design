module FA (input a, b, c_in, output sum, c_out);
    xor (sum, a, b, c_in);
    wire c1, c2, c3;
    and (c1, a, b); 
    and (c2, a, c_in); 
    and (c3, b, c_in);
    or (c_out, c1, c2, c3); 
endmodule



module csa_4 (input [3:0] A, B, 
            output reg [3:0] SUM1, SUM2, output reg cout_1, cout_2);



endmodule