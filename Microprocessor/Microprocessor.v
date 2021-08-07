`timescale 1ns / 1ps

module Microprocessor(
		input origclk,
		input reset,
		input [7:0] instruction,
		output reg [7:0] pc,
		output [6:0] display_low,
		output [6:0] display_high,
		output [6:0] display_op,
		output [6:0] display_rs,
		output [6:0] display_rt,
		output [6:0] display_rd,
		output [4:0] display_pc,
		output display_clock
	);

	wire [1:0] op = instruction[7:6];
	wire [1:0] rs = instruction[5:4];
	wire [1:0] rt = instruction[3:2];
	wire [1:0] rd = instruction[1:0];
	wire [7:0] imm = {
			instruction[1],
			instruction[1],
			instruction[1],
			instruction[1],
			instruction[1],
			instruction[1],
			instruction[1],
			instruction[0]
		};

	wire clk;

	wire reg_dst;
	wire reg_write;
	wire alu_src;
	wire branch;
	wire mem_read;
	wire mem_write;
	wire mem_to_reg;
	wire alu_op;

	wire [7:0] reg_data1;
	wire [7:0] reg_data2;

	wire [7:0] alu_result;
	wire [7:0] alu_operand2 =
		alu_src == 0
		? reg_data2
		: imm;

	wire [7:0] memory_output;

	wire [1:0] reg_write_reg =
		reg_dst == 0
		? rt
		: rd;
	wire [7:0] reg_write_data =
		mem_to_reg == 0
		? alu_result
		: memory_output;

	reg [7:0] display_write_data;
	assign display_pc = pc;
	assign display_clock = clk;
	
	ClockDivider divider(
			.clk_in(origclk),
			.reset(reset),
			.clk_out(clk)
		);

	Control control(
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

	Registers registers(
			.clk(clk),
			.reset(reset),
			.read_reg1(rs),
			.read_reg2(rt),
			.write(reg_write),
			.write_reg(reg_write_reg),
			.write_data(reg_write_data),
			.read_data1(reg_data1),
			.read_data2(reg_data2)
		);

	HexDecoder ssdecoder_high(
			.bcd(display_write_data[3:0]),
			.seg(display_low)
		);
	HexDecoder ssdecoder_low(
			.bcd(display_write_data[7:4]),
			.seg(display_high)
		);
	OpDecoder ssdecoder_op(
			.op(op),
			.seg(display_op)
		);
	HexDecoder ssdecoder_rs(
			.bcd(rs),
			.seg(display_rs)
		);
	HexDecoder ssdecoder_rt(
			.bcd(rt),
			.seg(display_rt)
		);
	HexDecoder ssdecoder_rd(
			.bcd(rd),
			.seg(display_rd)
		);

	ALU alu(
			.operand1(reg_data1),
			.operand2(alu_operand2),
			.result(alu_result)
		);

	DataMemory memory(
			.clk(clk),
			.reset(reset),
			.address(alu_result),
			.write(mem_write),
			.data_inputs(reg_data2),
			.data_outputs(memory_output)
		);

	initial begin
		pc = 0;
		display_write_data = 0;
	end

	always @(posedge reset or negedge clk) begin
		if (reset)
			pc <= 0;
		else
			pc <=
				branch == 0
				? pc + 1
				: pc + 1 + imm;
	end
	
	always @(posedge reset or posedge clk) begin
		if (reset)
			display_write_data <= 0;
		else
			display_write_data <= reg_write_data;
	end
endmodule
