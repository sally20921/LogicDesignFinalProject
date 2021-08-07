`timescale 1ns / 1ps

module RegistersTest;
	reg clk;
	reg reset;
	reg [1:0] read_reg1;
	reg [1:0] read_reg2;
	reg write;
	reg [1:0] write_reg;
	reg [7:0] write_data;

	wire [7:0] read_data1;
	wire [7:0] read_data2;

	Registers uut (
		.clk(clk),
		.reset(reset),
		.read_reg1(read_reg1),
		.read_reg2(read_reg2),
		.write(write),
		.write_reg(write_reg),
		.write_data(write_data),
		.read_data1(read_data1),
		.read_data2(read_data2)
	);

	initial begin
		read_reg1 = 0;
		read_reg2 = 0;
		write = 0;
		write_reg = 0;
		write_data = 0;
		reset = 1;
		clk = 0;
		#50;
		reset = 0;
		clk = 1;
		#50;
		clk = 0;
		#50;

		write_reg = 2'b10;
		write_data = 8'b01010101;
		write = 1;
		clk = 1;
		#50;
		clk = 0;
		#50;

		read_reg1 = 2'b11;
		write_reg = 2'b11;
		write_data = 8'b11001100;
		write = 1;
		clk = 1;
		#50;
		clk = 0;
		#50;

		read_reg2 = 2'b11;
		write = 0;
		clk = 1;
		#50;
		clk = 0;
		#50;
	end
endmodule

