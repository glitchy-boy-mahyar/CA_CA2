module processor(clk, rst);
    input clk, rst;
    wire reg_dst , jal_reg , pc_to_reg , alu_src , mem_to_reg ,
            jump_sel , pc_jump , pc_src , reg_write , mem_read , mem_write;
    wire [2:0] alu_cntrl;
    wire ZERO;
    wire [5:0] opcode, func;
    data_path dp(reg_dst , jal_reg , pc_to_reg , alu_src , mem_to_reg ,
            jump_sel , pc_jump , pc_src , reg_write , mem_read , mem_write , alu_cntrl ,
            clk , rst , ZERO, opcode, func);

    controller c(ZERO , opcode , func , reg_dst , jal_reg , pc_to_reg , alu_src , mem_to_reg ,
                jump_sel , pc_jump , pc_src , reg_write , mem_read , mem_write , alu_cntrl);
endmodule

module processor_test();
    reg clk, rst;
    processor mips(clk, rst);

    initial begin
        clk = 1'b1;
        repeat(1000) #50 clk = ~clk;
    end

    initial begin
        rst = 1'b1;
        #50 rst = 1'b0;
        #6600 $stop;
        
    end
endmodule