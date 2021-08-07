`timescale 1ns / 1ps
module FrequencyDivider(
    input CLKin,
    input clr,
    output reg CLKout
    );
	 reg [31:0] cnt;
	 always @(posedge CLKin) begin
		if(clr) begin
			cnt <= 32'd0;
			CLKout <= 1'b0;
		end
		else if(cnt == 32'd25000000) begin
			cnt <= 32'd0;
			CLKout <= ~CLKout;
		end
		else begin
			cnt <= cnt+1;
		end
	end
endmodule
