`timescale 1ns / 1ps

module Control(
		input [1:0] op,
		output reg_dst,
		output reg_write,
		output alu_src,
		output branch,
		output mem_read,
		output mem_write,
		output mem_to_reg,
		output alu_op
	);

	wire [7:0] out;
	assign {reg_dst, reg_write, alu_src, branch, mem_read, mem_write, mem_to_reg, alu_op} = out;

	assign out = op == 2'b00 ? 8'b11000001 : // 11000001
		op == 2'b01 ? 8'b01101010 : // 01101010
		op == 2'b10 ? 8'b00100100 : // x01001x0
		8'b00010000; // x00100x0
endmodule
