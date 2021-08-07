module seg7dec 
(
	input [3:0] val,
	output reg [6:0] seg // from MSB {A, B, C, D, E, F, G}
);

always @(*)
begin
	case (val[3:0])
		4'h0: seg[6:0] = 7'b111_1110;
		4'h1: seg[6:0] = 7'b011_0000;
		4'h2: seg[6:0] = 7'b110_1101;
		4'h3: seg[6:0] = 7'b111_1001;
		4'h4: seg[6:0] = 7'b011_0011;
		4'h5: seg[6:0] = 7'b101_1011;
		4'h6: seg[6:0] = 7'b101_1111;
		4'h7: seg[6:0] = 7'b111_0010;
		4'h8: seg[6:0] = 7'b111_1111;
		4'h9: seg[6:0] = 7'b111_1011;
		4'hA: seg[6:0] = 7'b111_0111;
		4'hB: seg[6:0] = 7'b111_1111;
		4'hC: seg[6:0] = 7'b100_1110;
		4'hD: seg[6:0] = 7'b111_1110;
		4'hE: seg[6:0] = 7'b100_1111;
		default: seg[6:0] = 7'b100_0111; // 4'hF
	endcase
end

endmodule