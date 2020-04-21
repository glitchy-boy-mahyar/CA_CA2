`include "constant_values.h"
`timescale 1 ns/1 ns
module data_path(reg_dst , jal_reg , pc_to_reg , alu_src , mem_to_reg ,
            jump_sel , pc_jump , pc_src , reg_write , mem_read , mem_write , alu_cntrl ,clk , rst , ZERO, opcode, func);
    output ZERO;
    input clk , rst;
    output reg [5:0] opcode, func;

    //control signals
    input reg_dst , jal_reg , pc_to_reg , alu_src , mem_to_reg ,
            jump_sel , pc_jump , pc_src , reg_write , mem_read , mem_write;
    input [2:0] alu_cntrl;

    //wires
    wire [31:0] pc_out , instructs , read_data , read_data_1 , read_data_2 , alu_result , sign_ext_out ,
                adder_pc_plus_4_out , adder_beq_out , shifter_1_out , shifter_2_out;
    //output of multiplexers
    wire [4:0] mux_reg_dst_out , mux_jal_reg_out;
    wire [31:0] mux_pc_to_reg_out , mux_alu_src_out , mux_mem_to_reg_out , mux_jump_sel_out , mux_pc_jump_out , mux_pc_src_out;


    pc program_counter(mux_pc_jump_out , pc_out , clk , rst);
    
    instruction_mem inst_mem(pc_out , instructs);

    register_file reg_file(instructs[25:21] , instructs[20:16] , mux_jal_reg_out , mux_pc_to_reg_out, reg_write , read_data_1 , read_data_2 , clk);
    
    alu alu_unit(read_data_1 , mux_alu_src_out , alu_result , ZERO , alu_cntrl);
    
    data_mem data_memory(alu_result , read_data_2 , read_data , mem_read , mem_write , clk);
    
    sign_ext_16_to_32 sign_extension(instructs[15:0] , sign_ext_out);
    
    adder adder_pc_plus_4(`FOUR , pc_out , adder_pc_plus_4_out);
    adder adder_beq(adder_pc_plus_4_out , shifter_1_out , adder_beq_out);
    
    shift_left_2 sfl1(sign_ext_out , shifter_1_out);
    shifter_for_jump sfl2(instructs , pc_out , shifter_2_out);
    
    mux_5_bit mux_reg_dst(instructs[20:16] , instructs[15:11] , mux_reg_dst_out , reg_dst);
    mux_5_bit mux_jal_reg(mux_reg_dst_out , `THIRTY_ONE , mux_jal_reg_out , jal_reg);
    
    mux_32_bit mux_pc_to_reg(mux_mem_to_reg_out , adder_pc_plus_4_out , mux_pc_to_reg_out , pc_to_reg);
    mux_32_bit mux_alu_src(read_data_2 , sign_ext_out , mux_alu_src_out , alu_src);
    mux_32_bit mux_mem_to_reg(alu_result , read_data , mux_mem_to_reg_out , mem_to_reg);
    mux_32_bit mux_jump_sel(read_data_1 , shifter_2_out, mux_jump_sel_out , jump_sel);
    mux_32_bit mux_pc_jump(mux_pc_src_out , mux_jump_sel_out , mux_pc_jump_out , pc_jump);
    mux_32_bit mux_pc_src(adder_pc_plus_4_out , adder_beq_out , mux_pc_src_out , pc_src);

    always @(instructs) begin
        opcode = instructs[31:26];
        func = instructs[5:0];
    end

endmodule