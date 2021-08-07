`timescale 1ns / 1ps

module MicroprocessorWithTestInst(
		input origclk,
		input reset,
		input [7:0] instruction,
		output [7:0] pc,
		output [7:0] test_instruction,
		input [7:0] test_pc,
		output [6:0] display_low,
		output [6:0] display_high,
		output [6:0] display_op,
		output [6:0] display_rs,
		output [6:0] display_rt,
		output [6:0] display_rd,
		output [5:0] display_pc
	);

	Microprocessor processer(
			.origclk(origclk),
			.reset(reset),
			.instruction(instruction),
			.pc(pc),
			.display_low(display_low),
			.display_high(display_high),
			.display_pc(display_pc),
			.display_op(display_op),
			.display_rs(display_rs),
			.display_rt(display_rt),
			.display_rd(display_rd)
		);

	wire [7:0] MemByte[20:0];

	assign MemByte[0] = 8'b01000100;
	assign MemByte[1] = 8'b01001001;
	assign MemByte[2] = 8'b00011001;
	assign MemByte[3] = 8'b10000100;

	assign MemByte[4] = 8'b01000100;
	assign MemByte[5] = 8'b01001001;
	assign MemByte[6] = 8'b00011001;
	assign MemByte[7] = 8'b10000100;

	assign MemByte[8] = 8'b01000100;
	assign MemByte[9] = 8'b01001001;
	assign MemByte[10] = 8'b00011001;
	assign MemByte[11] = 8'b10000100;

	assign MemByte[12] = 8'b01000100;
	assign MemByte[13] = 8'b01001001;
	assign MemByte[14] = 8'b00011001;
	assign MemByte[15] = 8'b10000100;

	assign MemByte[16] = 8'b01000100;
	assign MemByte[17] = 8'b01001001;
	assign MemByte[18] = 8'b00011001;
	assign MemByte[19] = 8'b10000100;

	assign MemByte[20] = 8'b11000011;

	assign test_instruction = MemByte[test_pc];
endmodule
