`timescale 1ns / 1ps

module HexDecoder(
		input [3:0] bcd,
		output [6:0] seg
	);

	assign seg = bcd == 4'd0 ? 7'b0111111 :
		bcd == 4'd1 ? 7'b0000110 :
		bcd == 4'd2 ? 7'b1011011 :
		bcd == 4'd3 ? 7'b1001111 :
		bcd == 4'd4 ? 7'b1100110 :
		bcd == 4'd5 ? 7'b1101101 :
		bcd == 4'd6 ? 7'b1111101 :
		bcd == 4'd7 ? 7'b0000111 :
		bcd == 4'd8 ? 7'b1111111 :
		bcd == 4'd9 ? 7'b1101111 :
		bcd == 4'd10 ? 7'b1110111 :
		bcd == 4'd11 ? 7'b1111100 :
		bcd == 4'd12 ? 7'b0111001 :
		bcd == 4'd13 ? 7'b1011110 :
		bcd == 4'd14 ? 7'b1111001 :
		7'b1110001;
endmodule
