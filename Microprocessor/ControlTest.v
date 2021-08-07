`timescale 1ns / 1ps

module ControlTest;
	reg [1:0] op;
	wire reg_dst;
	wire reg_write;
	wire alu_src;
	wire branch;
	wire mem_read;
	wire mem_write;
	wire mem_to_reg;
	wire alu_op;

	Control uut (
		.op(op),
		.reg_dst(reg_dst),
		.reg_write(reg_write),
		.alu_src(alu_src),
		.branch(branch),
		.mem_read(mem_read),
		.mem_write(mem_write),
		.mem_to_reg(mem_to_reg),
		.alu_op(alu_op)
	);

	initial begin
		op = 0;
	end

	always begin
		#100;
		op <= op + 1;
	end
endmodule

