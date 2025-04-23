module shift_rotate_TB();
    reg CLK = 0, SET = 0, CLR = 0, Sr_En, In;
    wire [3:0]q;
    shift_rotate sh_r (CLK, SET, CLR, Sr_En, In, q);
    
    always #5 CLK = ~CLK;
    
    initial
    begin
        $dumpfile("shift_rotate.vcd");
        $dumpvars(0,shift_rotate_TB);
        
        $monitor("SET = %b , CLR = %b , Sr_En = %b , In = %b  --->  q = %b", SET, CLR, Sr_En, In, q);
        
        // reset
        CLR = 1;  
        #10 CLR = 0;

        // serial‐load: Sr_En=1, shift in bits 1,0,1,1…
        #10 Sr_En = 1;
        In = 1; 
        #10 In = 0; 
        #10 In = 1; 
        #10 In = 1; 

        // now rotate right 4 times
        #10 Sr_En = 0;
        #40;

        // test async set
        SET = 1; 
        #10 SET = 0;

        #10 $finish;
	  end
endmodule