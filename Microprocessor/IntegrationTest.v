`timescale 1ns / 1ps

module IntegrationTest;
	reg origclk;
	reg reset;
	reg [7:0] instruction;
	wire [7:0] pc;
	wire [6:0] display_low;
	wire [6:0] display_high;
	wire [6:0] display_op;
	wire [6:0] display_rs;
	wire [6:0] display_rt;
	wire [6:0] display_rd;
	wire [4:0] display_pc;
	wire display_clock;

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

	Microprocessor uut (
		.origclk(origclk),
		.reset(reset),
		.instruction(instruction),
		.pc(pc),
		.display_low(display_low),
		.display_high(display_high),
		.display_op(display_op),
		.display_rs(display_rs),
		.display_rt(display_rt),
		.display_rd(display_rd),
		.display_pc(display_pc),
		.display_clock(display_clock)
	);

	initial begin
		origclk = 0;
		instruction = MemByte[0];
		reset = 0;
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
		instruction <= MemByte[pc];
	end
endmodule
