module controller #(parameter CLK_PERIOD = 2) (input clk, reset);
    reg [15:0] PC;
    reg [15:0] instruction;
    reg [2:0] opcode;
    reg [1:0] rs1, rs2, rd; 
    reg signed [15:0] operator1, operator2, result;
    reg signed [15:0] fetched_address;

    reg mem_write_enable, mem_read_enable;
    reg [15:0] mem_address;
    reg signed [15:0] mem_write_data;
    wire signed [15:0] mem_read_data;

    memory mem (clk, mem_write_enable, mem_read_enable, mem_address, mem_write_data, mem_read_data);

    reg alu_start;
    reg [2:0] alu_opcode;
    reg signed [15:0] A, B;
    wire signed [15:0] alu_result;
    wire alu_done;
    
    alu_16 alu (clk, reset, alu_start, alu_opcode, A, B, alu_result, alu_done);

    reg reg_write_enable;
    reg [1:0] write_reg_num, read_reg_1_num, read_reg_2_num;
    reg signed [15:0] reg_write_data;
    wire signed [15:0] read_data_1, read_data_2;
    
    register_file rf (clk, reset, reg_write_enable, write_reg_num,
                    read_reg_1_num, read_reg_2_num, reg_write_data, read_data_1, read_data_2);


    localparam FETCH = 0, DECODE = 1, READ_REGISTER_FILE = 2, EXECUTION = 3, 
                LOAD_WAIT = 4, ALU_WAIT = 5, WRITE_BACK = 6, DONE = 7;
    reg [2:0] state;

    always @(posedge clk, posedge reset) begin
        if (reset) begin
            state <= FETCH;
        end else begin
            case (state)
                FETCH: begin
                    mem_write_enable <= 0;
                    mem_read_enable <= 1;
                    mem_address <= PC;
                    instruction <= mem_read_data;
                    state <= DECODE;
                end

                DECODE: begin
                    opcode <= instruction[15:13];
                    rd <= instruction[12:11];
                    rs1 <= instruction[10:9];
                    if (instruction[15]) // So this is M_Type instruction. Because M_type starts with 1
                        rs2 <= instruction[8:7];
                    else 
                        fetched_address <= $signed(instruction[8:0]);
                    state <= READ_REGISTER_FILE;
                end

                READ_REGISTER_FILE: begin
                    reg_write_enable <= 0;
                    
                    read_reg_1_num <= rs1;
                    if (opcode == 3'b101) 
                        read_reg_2_num <= rd; // In STORE we don't have write back => we should read data from rd
                    else read_reg_2_num <= rs2;

                    operator1 <= read_data_1;
                    operator2 <= read_data_2;
                    state <= EXECUTION;
                end
                
                EXECUTION: begin
                    if (opcode[2]) begin // So this is M_Type instruction. Because M_type starts with 1
                        mem_address <= fetched_address + operator1;
                        if (opcode == 3'b100) begin // LOAD
                            mem_write_enable <= 0;
                            mem_read_enable <= 1;
                            state <= LOAD_WAIT;
                        end else begin // STORE... If we add instructions (means adding opcode) we should change this part later :)
                            mem_write_enable <= 1;
                            mem_read_enable <= 0;
                            mem_write_data <= operator2;
                            state <= DONE;
                        end
                    end else begin // This block is for ALU execution
                        alu_start <= 1;
                        alu_opcode <= opcode;
                        A <= operator1;
                        B <= operator2;
                        state <= ALU_WAIT;
                    end
                end

                LOAD_WAIT: begin
                    result <= mem_read_data; 
                    state <= WRITE_BACK; 
                end 
                
                ALU_WAIT: begin
                    alu_start <= 0;
                    if (alu_done) begin 
                        result <= alu_result;
                        state <= WRITE_BACK;
                    end
                end
                
                WRITE_BACK: begin
                    reg_write_enable <= 1;
                    write_reg_num <= rd;
                    reg_write_data <= result;
                    state <= DONE;
                end

                DONE: begin
                    PC = PC + 1;
                    state <= FETCH;
                end
            endcase
        end
    end

endmodule