`timescale 1 ns / 1 ns
`include "constant_values.h"

module instruction_mem(address, instruction);
    input [31:0] address;
    output reg [31:0] instruction;
    reg [7:0] mem [0:2 ** 16 - 1];
    
    always @(address) begin
        instruction = {mem[address[15:0]], mem[address[15:0] + 1], 
                mem[address[15:0] + 2], mem[address[15:0] + 3]};
        $display("@%t: INST_MEM: data at address %d is read", $time, address);
    end

    initial begin
    //    $readmemb("test_1.bin", mem);
          $readmemb("test_2.bin", mem);
    end
    
endmodule

module inst_mem_test();
    reg [31:0] address;
    wire [31:0] instruction;
    instruction_mem inst_mem_test(address, instruction);
    integer i;

    initial begin
        address = 32'b0;
        for (i = 0; i < 4; i = i + 1)
            #500 address = 4 * i;
        #1000;
    end

endmodule