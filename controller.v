`include "constant_values.h"
`timescale 1 ns/1 ns
module controller(ZERO , opcode , func , reg_dst , jal_reg , pc_to_reg , alu_src , mem_to_reg ,
                jump_sel , pc_jump , pc_src , reg_write , mem_read , mem_write , alu_operation);
    input ZERO;
    input [5:0] opcode , func;
    output reg reg_dst , jal_reg , pc_to_reg , alu_src , mem_to_reg ,
                jump_sel , pc_jump , pc_src , reg_write , mem_read , mem_write;
    output [2:0] alu_operation;

    //alu_op parameters
    parameter MTYPE = 2'b00; // Memorey accses
    parameter BTYPE = 2'b01; // Branch
    parameter RTYPE = 2'b10; // Register
    parameter JTYPE = 2'b11; //Jump

    //opcode parameters
    parameter REGISTER_TYPE = 6'b000000;
    parameter LW = 6'b100011;
    parameter SW = 6'b101011;
    parameter BEQ = 6'b000100;
    parameter BNE = 6'b000101;
    parameter J = 6'b000010;
    parameter JAL = 6'b000011;
    parameter ADDI = 6'b001000;
    parameter ANDI = 6'b001100;

    //function parameter
    parameter JR = 6'b001000;
    parameter ADD = 6'b100000;
    parameter AND = 6'b100100;

    reg [1:0] alu_op;
    reg branch;
    reg [5:0] functions;

    alu_controller alucntrl(alu_op, functions, alu_operation);

    //determine function for addi/andi
    always @(opcode or func) begin
        functions = 6'b0;
        if (opcode == ADDI)
            functions = ADD;
        else if (opcode == ANDI)
            functions = AND;
        else
            functions = func;
    end

    //signal branch
    always @(opcode) begin
        if(opcode == BEQ || opcode == BNE) begin
            branch = 1'b1;
        end
        else begin
            branch = 1'b0;
        end
    end

    always @(opcode or functions or ZERO or branch) begin
        {reg_dst, jal_reg, pc_to_reg, alu_src, mem_to_reg,
                jump_sel, pc_jump, pc_src, reg_write, mem_read, mem_write} = 11'b0;
        
        alu_op = 2'bzz;
        
        case (opcode)
            REGISTER_TYPE: begin
                if(functions != JR)begin
                    reg_dst = 1'b1;
                    pc_src = ZERO & branch;
                    reg_write = 1'b1;
                    alu_op = RTYPE;
                end
                else if(functions == JR)begin
                    pc_jump = 1'b1;
                    alu_op = JTYPE;
                end
            end

            SW: begin
                alu_src = 1'b1;
                pc_src = ZERO & branch;
                mem_write = 1'b1;
                alu_op = MTYPE;
            end

            LW: begin
                alu_src = 1'b1;
                mem_to_reg = 1'b1;
                pc_src = ZERO & branch;
                reg_write = 1'b1;
                mem_read = 1'b1;
                alu_op = MTYPE;
            end

            BEQ: begin
                pc_src = ZERO & branch;
                alu_op = BTYPE;
            end

            BNE: begin
                pc_src = ~ZERO & branch;
                alu_op = BTYPE;
            end

            J: begin
                jump_sel = 1'b1; 
                pc_jump = 1'b1;
                alu_op = JTYPE;
            end

            JAL: begin
                jal_reg = 1'b1; 
                pc_to_reg = 1'b1;
                jump_sel = 1'b1; 
                pc_jump = 1'b1;
                reg_write = 1'b1;
                alu_op = JTYPE;
            end

            ADDI: begin
                alu_src = 1'b1; 
                pc_src = ZERO & branch;
                reg_write = 1'b1;
                alu_op = RTYPE;
            end

            ANDI: begin
                alu_src = 1'b1; 
                pc_src = ZERO & branch;
                reg_write = 1'b1;
                alu_op = RTYPE;
            end

        endcase
    end
    
endmodule