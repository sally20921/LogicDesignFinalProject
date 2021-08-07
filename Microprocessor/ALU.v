`timescale 1ns / 1ps

module ALU(
		input [7:0] operand1,
		input [7:0] operand2,
		output [7:0] result
	);

	assign result = operand1 + operand2;
endmodule
