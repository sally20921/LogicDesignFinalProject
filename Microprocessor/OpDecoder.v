`timescale 1ns / 1ps

module OpDecoder(
		input [1:0] op,
		output reg [6:0] seg
	);

	always @(op) begin
		case (op)
			2'd0: seg <= 7'b1110111; // A
			2'd1: seg <= 7'b0111000; // L
			2'd2: seg <= 7'b1101101; // S
			2'd3: seg <= 7'b0001110; // J
		endcase
	end
endmodule

