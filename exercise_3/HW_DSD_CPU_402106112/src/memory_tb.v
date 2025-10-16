module memory_tb ();

    localparam CLK_PERIOD = 2;

    reg clk;
    reg write_enable, read_enable;
    reg [15:0] address;
    reg signed [15:0] write_data;
    wire signed [15:0] read_data;

    memory mem_inst (clk, write_enable, read_enable, address, write_data, read_data);
    
    always #(CLK_PERIOD/2) clk = ~clk;

    // Two tasks : For reading and writing data
    task write_mem(input [15:0] addr, input [15:0] data);
    begin
        write_enable = 1;
        address = addr;
        write_data = data;
        #CLK_PERIOD; // We wait one clock cycle to writing completion
    end
    endtask

    task read_mem(input [15:0] addr);
    begin
        read_enable = 1;
        address = addr;
        #CLK_PERIOD; // We wait one clock cycle to reading completion
        $display("Read mem[%0d]: %0d (exp: %0d)", addr, read_data, $signed(mem_inst.mem[addr]));
    end
    endtask


    initial begin
        $dumpfile("memory.vcd");
        $dumpvars(0, memory_tb);

        clk = 0;
        write_enable = 0; read_enable = 0; address = 0; write_data = 0;
        
        #CLK_PERIOD;
        // Write values
        write_mem(16'd10, -16'd1234);
        write_mem(16'd110, 16'd5678);
        write_mem(16'd1200, 16'd9999);
        
        write_enable = 0;

        // Read values
        read_mem(16'd10);
        read_mem(16'd110);
        read_mem(16'd1200);
        read_mem(16'd1000);
        
        read_enable = 0;

        $finish;
    end
endmodule