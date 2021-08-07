`timescale 1ns / 1ps

module ClockDivider(
		input clk_in,
		input reset,
		output reg clk_out
	);

	reg [31:0] cnt;

	initial begin
		clk_out <= 1'b0;
		cnt <= 0;
	end

	always @(posedge reset or posedge clk_in) begin
		if (reset) begin
			clk_out <= 1'b0;
			cnt <= 0;
		end else if (cnt >= 32'd25000000) begin
		// end else if (cnt >= 32'd10) begin
			cnt <= 32'b0;
			clk_out <= ~clk_out;
		end else begin
			cnt <= cnt + 1;
		end
	end
endmodule
