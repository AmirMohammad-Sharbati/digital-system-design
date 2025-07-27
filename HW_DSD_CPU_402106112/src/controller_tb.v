module controller_tb ();
    reg clk, reset;
    localparam CLK_PERIOD = 2;
    integer i;

    controller #(CLK_PERIOD) cpu (clk, reset);

    always #(CLK_PERIOD/2) clk = ~clk;

    // Initialize memory manually
    initial begin
        $dumpfile("controller_tb.vcd");
        $dumpvars(0, controller_tb);
        clk = 0;
        reset = 1;

        // Wait for reset
        #(CLK_PERIOD);
        reset = 0;
        cpu.PC = 0;
        
        // 1) Initialize some numbers in register file
        cpu.rf.registers[0] = -61;   // x0 = -61
        cpu.rf.registers[1] = 0;     // x1 = 0  
        cpu.rf.registers[2] = 5;     // x2 = 5
        cpu.rf.registers[3] = 10;    // x3 = 10;

        // 2) second part is writing some binary numbers in memory (They are instruction).
        cpu.mem.mem[0] = 16'b000_01_00_00_0010010; // ADD x1, x0, x0 => x1 = -122
        cpu.mem.mem[1] = 16'b011_10_01_10_1001100; // DIV x2, x1, x2 => x2 = -122/5 = -24
        cpu.mem.mem[2] = 16'b001_00_10_00_0101010; // SUB x0, x2, x0 => x0 = -24-(-61) = 37
        cpu.mem.mem[3] = 16'b010_01_11_00_1111111; // MUL x1, x3, x0 => x1 = 370
        cpu.mem.mem[4] = 16'b011_11_00_11_0011001; // DIV x3, x0, x3 => x3 = 37/10 = 3  
        cpu.mem.mem[5] = 16'b000_11_11_01_0000000; // ADD x3, x3, x1 => x3 = 373
        cpu.mem.mem[6] = 16'b001_01_00_11_0101010; // SUB x1, x0, x3 => x1 = 37 - 373 = -336
        cpu.mem.mem[7] = 16'b010_01_00_10_1111111; // MUL x1, x0, x2 => x1 = 37 * (-24) = -888
        cpu.mem.mem[8] = 16'b101_00_11_110000000; // STORE x0, x3, -128 => mem[373 + (-128)] = mem[245] = x0 = 37 
        cpu.mem.mem[9] = 16'b100_10_00_011010000; // LOAD x2, x0, 208  => x2 = mem[37 + 208] = mem[245] = 37
        cpu.mem.mem[10] = 16'b001_00_10_01_0101001; // SUB x0, x2, x1 => x0 = 37 - (-888) = 925  

        repeat (11) begin
            @(posedge clk);
            while (!cpu.ready) // Wait until ready signal becomes 1
                @(posedge clk);
        end // We have 11 instructions. 

        $display("Reg x0 = %d (exp = 925)", cpu.rf.registers[0]);
        $display("Reg x1 = %d (exp = -888)", cpu.rf.registers[1]);
        $display("Reg x2 = %d (exp = 37)", cpu.rf.registers[2]);
        $display("Reg x3 = %d (exp = 373)", cpu.rf.registers[3]);
        $display("Mem[245] = %d (exp = 37)", cpu.mem.mem[245]);

        $finish;
    end
endmodule           
