`include "constant_values.h"
`timescale 1 ns / 1 ns
module alu(a, b, y, zero, alu_ctrl);
    input [31:0] a;
    input [31:0] b;
    output reg [31:0] y;
    output reg zero;
    input [1:0] alu_ctrl;

    always @(alu_ctrl, a, b) begin
        case (alu_ctrl)
            `AND: y = a & b;
            `OR: y = a | b;
            `ADD: y = a + b;
            `SUB: y = a - b;
        endcase
    end

    always @(y) begin
        zero = 1'b0;
        if (y == `WORD_ZERO)
            zero = 1'b1;
    end
endmodule

module alu_test();
    reg [31:0] a;
    reg [31:0] b;
    wire [31:0] y;
    wire zero;
    reg [1:0] alu_ctrl;
    parameter [1:0] AND = 2'b00;
    parameter [1:0] OR = 2'b01;
    parameter [1:0] ADD = 2'b10;
    parameter [1:0] SUB = 2'b11;

    alu alu_test(a, b, y, zero, alu_ctrl);

    initial begin
    a = 32'b0000000000000000_0000000000001000;
    b = 32'b0000000000000000_0000000000101001;
    #500 alu_ctrl = `SUB;
    #500 b = 32'b0000000000000000_0000000000001000;
    #500 a = 32'b0000000000000000_0000000000101001;
    #500 alu_ctrl = `ADD;
    #500 alu_ctrl = `AND;
    #500 alu_ctrl = `OR;
    #1000;
    end

endmodule