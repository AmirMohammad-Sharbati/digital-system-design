module memory (
    input clk, 
    input write_enable, read_enable,
    input [15:0] address,
    input [15:0] write_data,
    output reg [15:0] read_data  
);

    localparam MEM_DEPTH = 1 << 16; // This gives 2^16

    reg [15:0] mem [0:MEM_DEPTH-1]; // 2^16 words, each 16-bit

    always @(posedge clk) begin
        if (write_enable) 
            mem[address] <= write_data;
        else if (read_enable)
            read_data <= mem[address]; 
    end
endmodule