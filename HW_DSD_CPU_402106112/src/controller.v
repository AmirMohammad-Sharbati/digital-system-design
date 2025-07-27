module controller #(parameter CLK_PERIOD = 2) (input clk, reset);
    reg [15:0] PC;
    reg [15:0] instruction;
    reg [2:0] opcode;
    reg [1:0] rs1, rs2, rd; 
    reg signed [15:0] result;
    reg signed [15:0] fetched_address;
    reg ready;

    reg mem_write_enable, mem_read_enable;
    reg [15:0] mem_address;
    reg signed [15:0] mem_write_data;
    wire signed [15:0] mem_read_data; 
    
    // If memory was not used for both instruction and data, we could remove LOAD_WAIT and FETCH_WAIT states. 
    // We could still do this now, but for clarity and readability, we use instruction and result signals.
    // But if the main goal is to reduce execution time, we can remove LOAD_WAIT and FETCH_WAIT states. 
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
    wire signed [15:0] operator1, operator2;
    
    register_file rf (clk, reset, reg_write_enable, write_reg_num,
                    read_reg_1_num, read_reg_2_num, reg_write_data, operator1, operator2);


    localparam FETCH = 0, FETCH_WAIT_1 = 1, FETCH_WAIT_2 = 2, DECODE = 3, READ_REGISTER_FILE = 4, 
            EXECUTION = 5, LOAD_WAIT_1 = 6, LOAD_WAIT_2 = 7, ALU_WAIT = 8, WRITE_BACK = 9, DONE = 10;
    reg [3:0] state;

    always @(posedge clk, posedge reset) begin
        if (reset) begin
            ready <= 0;
            state <= FETCH;
        end else begin
            case (state)
                FETCH: begin
                    ready <= 0;
                    mem_write_enable <= 0;
                    mem_read_enable <= 1;
                    mem_address <= PC;
                    state <= FETCH_WAIT_1;
                end

                FETCH_WAIT_1: begin // Delay one clock cycle for reading from memory (This is also used for load instruction)
                    state <= FETCH_WAIT_2;
                end

                FETCH_WAIT_2: begin
                    instruction <= mem_read_data;
                    state <= DECODE;
                end

                DECODE: begin
                    opcode <= instruction[15:13];
                    rd <= instruction[12:11];
                    rs1 <= instruction[10:9];
                    if (instruction[15]) // So this is M_Type instruction. Because M_type starts with 1
                        fetched_address <= $signed(instruction[8:0]);
                    else 
                        rs2 <= instruction[8:7];
                    state <= READ_REGISTER_FILE;
                end

                READ_REGISTER_FILE: begin
                    reg_write_enable <= 0;
                    
                    read_reg_1_num <= rs1;
                    if (opcode == 3'b101) 
                        read_reg_2_num <= rd; // In STORE we don't have write back => we should read data from rd
                    else read_reg_2_num <= rs2;
                    state <= EXECUTION;
                end
                
                EXECUTION: begin
                    if (opcode[2]) begin // So this is M_Type instruction. Because M_type starts with 1
                        mem_address <= fetched_address + operator1;
                        if (opcode == 3'b100) begin // LOAD
                            mem_write_enable <= 0;
                            mem_read_enable <= 1;
                            state <= LOAD_WAIT_1;
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

                LOAD_WAIT_1: begin // One clock cycle delay for reading from memory.
                    state <= LOAD_WAIT_2;
                end 

                LOAD_WAIT_2: begin
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
                    ready <= 1;
                    PC <= PC + 1;
                    state <= FETCH;
                end

                default: state <= FETCH;
            endcase
        end
    end

endmodule