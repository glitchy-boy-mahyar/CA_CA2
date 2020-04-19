`include "constant_values.h"
`timescale 1 ns / 1 ns
module alu(a, b, y, zero, alu_ctrl);
    input [31:0] a;
    input [31:0] b;
    output reg [31:0] y;
    output reg zero;
    input [2:0] alu_ctrl;

    always @(alu_ctrl, a, b) begin
        case (alu_ctrl)
            `AND: y = a & b;
            `OR: y = a | b;
            `ADD: y = a + b;
            `SUB: y = a - b;
            `SLT: begin
                if (a[31] == 1'b1 && b[31] == 1'b1)
                    y = a < b;
                else if (a[31] == 1'b0 && b[31] == 1'b1)
                    y = {31'b0, 1'b1};
                else if (a[31] == 1'b1 && b[31] == 1'b0)
                    y = 32'b0;
                else if (a[31] == 1'b0 && b[31] == 1'b0)
                    y = a < b; 
            end
            `OFF: y = `WORD_Z;
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
    reg [2:0] alu_ctrl;

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
    #500 alu_ctrl = `SLT;
    #500 b = 32'b1111111111111111_1111111111111111;
    #500 a = 32'b1111111111111111_1111111111111101;
    b = 32'b1111111111111111_1111111111111011;
    #500 a = 32'b1111111111111111_1111111111111011;
    b = 32'b1111111111111111_1111111111111101;
    #1000;
    end

endmodule
