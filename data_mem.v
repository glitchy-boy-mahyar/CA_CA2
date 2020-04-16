`timescale 1 ns / 1 ns
`include "constant_values.h"

module data_mem(address, write_data, read_data, 
		mem_read, mem_write, clk);
	
	input [31:0] address;
	input [31:0] write_data;
	output reg [31:0] read_data;
	input mem_read, mem_write;
	input clk;
	
	reg [31:0] mem[0:2 ** 16 - 1];
	
	// uncommenting the following lines would
	// load the memory with some initial values
	// from the given directory
	initial begin
		$readmemb("test_1.txt", mem);
	end
	
	always @(posedge clk) begin
		if (mem_write == 1'b1)
			mem[address[15:0]] <= write_data;
	end

	always @(mem_read or address) begin
		if (mem_read == 1'b1)
			read_data = mem[address[15:0]];
		else
			read_data = `WORD_ZERO;
	end

	// assign read_data = (mem_read == 1'b1) ? mem[address[15:0]] : `WORD_ZERO;
	
	// following line is to save the memory data to txt file
	// initial begin
		// $writememb("test_1.txt", mem);
	// end

	
endmodule

module data_mem_test();
	reg [31:0] address, write_data;
	wire [31:0] read_data;
	reg mem_read, mem_write, clk;
	data_mem data_mem_test(address, write_data, read_data, mem_read, mem_write, clk);

	initial begin
		clk = 1'b1;
		repeat(200) #50 clk = ~clk;
	end

	initial begin
		mem_read = 1'b0;
		address = 32'b0000000000000000_0000000000000010;
		#100 write_data = 32'b0000000000000000_1111111111111111;
		mem_write = 1'b1;
		#100 write_data = `WORD_ZERO;
		mem_write = 1'b0;
		address = `WORD_ZERO;

		#1000 address = 32'b0000000000000000_0000000000000010;
		mem_read = 1'b1;
		#1000 mem_read = 1'b0;
		#500 address = 32'b0000000000000000_0000000000001011;
		mem_write = 1'b1;
		write_data = 32'b1111111111111111_0000000000000000;
		#100 mem_write = 1'b0;
		address = `WORD_ZERO;
		#1000 address = 32'b0000000000000000_0000000000001011;
		mem_read = 1'b1;
		#1450 address = 32'b0000000000000000_0000000000001100;
	end
endmodule

module data_mem_test_2();
	reg [31:0] address, write_data;
	wire [31:0] read_data;
	reg mem_read, mem_write, clk;
	data_mem data_mem_test_2(address, write_data, read_data, mem_read, mem_write, clk);

	initial begin
		clk = 1'b1;
		repeat(1000) #50 clk = ~clk;
	end

	integer i;
	initial begin
		mem_read = 1'b1;
		address = `WORD_ZERO;
		for (i = 0; i < 100; i = i + 1)
			#500 address = address + 1;
	end
endmodule
