`timescale 1ns / 1ps

module Registers(
		input clk,
		input reset,
		input [1:0] read_reg1,
		input [1:0] read_reg2,
		input write,
		input [1:0] write_reg,
		input [7:0] write_data,
		output [7:0] read_data1,
		output [7:0] read_data2
	);

	reg [7:0] registers[3:0];
	integer i;
	
	assign read_data1 = registers[read_reg1];
	assign read_data2 = registers[read_reg2];

	initial begin
		for (i = 0; i < 4; i = i + 1)
			registers[i] <= 0;
	end

	always @(posedge reset or posedge clk) begin
		if (reset) begin
			for (i = 0; i < 4; i = i + 1)
				registers[i] <= 0;
		end else begin
			if (write)
				registers[write_reg] <= write_data;
		end
	end
endmodule
