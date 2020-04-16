`timescale 1 ns / 1 ns
`include "constant_values.h"

module register_file(read_reg1, read_reg2, write_reg, write_data,
                        regWrite, regDst, read_data1, read_data2 , clk);

    input [4:0] read_reg1, read_reg2 , write_reg;
    input [31:0] write_data;
    output reg [31:0] read_data1 , read_data2;
    input regWrite , regDst;
    input clk;

    reg [31:0] registers [31:0];

    //reading registers from file
    //initial begin
	//	$readmemb("registers.txt", registers);
	//end

    always @(read_reg1, read_reg2) begin
		read_data1 = registers[read_reg1];
		read_data2 = registers[read_reg2];
	end

    always @(posedge clk) begin
        if(regWrite) begin
            if(regDst) begin
				registers[write_reg] = write_data;
			end
			else begin
                registers[read_reg2] = write_data;
			end
        end
    end

    //writing to registers after operations finished
    //$writememb("registers.mem",registers);
            
endmodule