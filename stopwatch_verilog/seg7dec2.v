module seg7dec2
(
	input [7:0] val,
	output [6:0] highDigit,
	output [6:0] lowDigit
);

wire [3:0] hundreds;
wire [3:0] tens;
wire [3:0] ones;

bin2bcd bcd(.binary(val), .Hundreds(hundreds), .Tens(tens), .Ones(ones));

seg7dec high(.val(tens), .seg(highDigit));
seg7dec low(.val(ones), .seg(lowDigit));

endmodule
