`timescale 1 ns / 1 ns
`include "constant_values.h"
module pc(in, out, clk , rst);
    input [31:0] in;
    output reg [31:0] out = `WORD_ZERO;
    input clk , rst;

    always @(posedge clk or posedge rst)begin
        if(rst)begin
            out <= 32'b0000000000000000_0000000000000000;
        end
        out <= in;
    end

endmodule

module pc_test();
    reg [31:0] in;
    wire [31:0] out;
    reg clk;

    pc pc_test(in, out, clk);

    initial begin
        clk = 1'b1;
        repeat(200) #50 clk = ~clk;
    end

    initial begin
        #450 in = 32'b0000111100001111_0000111100001111;
        #400 in = 32'b0101010101010101_0101010101010101;
        #850 in = 32'b0110011001100110_0110011001100110;
        #1000; 
    end

endmodule
