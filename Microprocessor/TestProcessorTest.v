`timescale 1ns / 1ps

module TestProcessorTest;
	reg origclk;
	reg reset;
	reg [7:0] instruction;
	reg [7:0] test_pc;

	wire [7:0] pc;
	wire [7:0] test_instruction;
	wire [6:0] display_low;
	wire [6:0] display_high;
	wire [6:0] display_op;
	wire [6:0] display_rs;
	wire [6:0] display_rt;
	wire [6:0] display_rd;
	wire [5:0] display_pc;

	MicroprocessorWithTestInst uut (
		.origclk(origclk),
		.reset(reset),
		.instruction(instruction),
		.pc(pc),
		.test_instruction(test_instruction),
		.test_pc(test_pc),
		.display_low(display_low),
		.display_high(display_high),
		.display_op(display_op),
		.display_rs(display_rs),
		.display_rt(display_rt),
		.display_rd(display_rd),
		.display_pc(display_pc)
	);

	initial begin
		origclk = 0;
		reset = 0;
		instruction = 0;
		test_pc = 0;
		#10;
		reset = 1;
		#10;
		reset = 0;
	end

	always begin
		origclk = 1;
		#1;
		origclk = 0;
		#1;
	end

	always @(pc) begin
		test_pc <= pc;
	end

	always @(test_instruction) begin
		instruction <= test_instruction;
	end
endmodule

