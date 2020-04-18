`include "constant_values.h"
`timescale 1 ns/1 ns
module data_path(reg_dst , jal_reg , pc_to_reg , alu_src , mem_to_reg ,
            jump_sel , pc_jump , pc_src , reg_write , mem_read , mem_write , alu_cntrl ,clk , rst , ZERO);
    output reg ZERO;
    input clk , rst;
    
    //control signals
    input reg_dst , jal_reg , pc_to_reg , alu_src , mem_to_reg ,
            jump_sel , pc_jump , pc_src , reg_write , mem_read , mem_write;
    input [2:0] alu_cntrl;

    //wires
    wire [31:0] pc_out , instructs , read_data , read_data_1 , read_data_2 , alu_result , sign_ext_out ,
                adder_1_out , adder_2_out , shifter_1_out , shifter_2_out;
    //output of multiplexers
    wire [4:0] mux1 , mux2;
    wire [31:0] mux3 , mux4 , mux5 , mux6 , mux7 , mux8;


    pc program_counter(mux7 , pc_out , clk , rst);
    instruction_mem inst_mem(pc_out , instructs);
    register_file reg_file(instructs[25:21] , instructs[20:16] , mux2 , mux3, reg_write , read_data_1 , read_data_2 , clk);
    alu alu_unit(read_data_1 , mux4 , alu_result , ZERO , alu_cntrl);
    data_mem data_memory(alu_result , read_data_2 , read_data , mem_read , mem_write , clk);
    sign_ext_16_to_32 sign_extension(instructs[15:0] , sign_ext_out);
    adder adder_1(`FOUR , pc_out , adder_1_out);
    adder adder_2(adder_1_out , shifter_1_out , adder_2_out);
    shift_left_2 sfl1(sign_ext_out , shifter_1_out);
    shifter_for_jump sfl2(instructs , pc_out , shifter_2_out);
    mux_5bit mux_reg_dst(instructs[20:16] , instructs[15:11] , mux1 , reg_dst);
    mux_5bit mux_jal_reg(mux1 , `THIRTY_ONE , mux2 , jal_reg);
    mux_32bit mux_pc_to_reg(mux5 , adder_1_out , mux3 , pc_to_reg);
    mux_32bit mux_alu_src(read_data_2 , sign_ext_out , mux4 , alu_src);
    mux_32bit mux_mem_to_reg(alu_result , read_data , mux5 , mem_to_reg);
    mux_32bit mux_jump_sel(read_data_1 , shifter_2_out, mux6 , jump_sel);
    mux_32bit mux_pc_jump(mux8 , mux6 , mux7 , pc_jump);
    mux_32bit mux_pc_src(adder_1_out , adder_2_out , mux8 , pc_src);



endmodule