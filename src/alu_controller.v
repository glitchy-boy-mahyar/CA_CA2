`timescale 1 ns / 1 ns
`include "./src/constant_values.h"

module alu_controller(alu_op, func, alu_operation);
    input [1:0] alu_op;
    input [5:0] func;
    output reg [2:0] alu_operation;

    parameter MTYPE = 2'b00; // Memorey accses
    parameter BTYPE = 2'b01; // Branch
    parameter RTYPE = 2'b10; // Register
    parameter JTYPE = 2'b11; //Jump

    parameter ADD = 6'b100000;
    parameter SUB = 6'b100010;
    parameter AND = 6'b100100;
    parameter OR = 6'b100101;
    parameter SLT = 6'b101010;

    always @(alu_op or func) begin
        alu_operation = `OFF;
        case(alu_op)
            MTYPE: begin
                alu_operation = `ADD;
                $display("@%t: ALU_CTRL::MTYPE", $time);
            end

            BTYPE: begin
                alu_operation = `SUB;
                $display("@%t: ALU_CTRL::BTYPE", $time);
            end

            RTYPE: begin
                case(func)
                    ADD: begin
                        alu_operation = `ADD;
                    end

                    SUB: begin
                        alu_operation = `SUB;
                    end

                    AND: begin 
                        alu_operation = `AND;
                    end

                    OR: begin
                        alu_operation = `OR;
                    end

                    SLT: begin
                        alu_operation = `SLT;
                    end

                    default: alu_operation = `OFF; 
                endcase
                $display("@%t: ALU_CTRL::RTYPE: func = %d", $time, func);
            end

            JTYPE: begin
                alu_operation = `OFF;
                $display("@%t: ALU_CTRL::JTYPE", $time);
            end

            default: alu_operation = `OFF;
        endcase
    end
endmodule
