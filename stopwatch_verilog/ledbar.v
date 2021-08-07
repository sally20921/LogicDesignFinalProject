module ledbar
(
	input mclk,
	
	input b1,
	input reset,
	input run,
	
	output reg [3:0] led = 4'b0000
);

//디바운싱, 엣지 검출용
reg b1Delayed0 = 1'b0;
reg b1Delayed1 = 1'b0;
reg b1Delayed2 = 1'b0;
wire posedgeDetect1;

//positive edge 감지
assign posedgeDetect1 = ~b1Delayed2 & b1Delayed1;
//positive edge 감지 end

//분주용
reg [19:0] clk100hz = 20'h0_0000;

reg [2:0] ledState = 3'h0;

always @(posedge mclk)
begin
	if(reset == 1'b1)
	begin
	led <= 4'b0000;
	clk100hz <= 20'h0_0000;
	ledState <= 3'h0;
	
	b1Delayed0 <= 1'b0;
	b1Delayed1 <= 1'b0;
	b1Delayed2 <= 1'b0;
	end
	else
	begin
		//디바운싱, 엣지 검출
		b1Delayed0 <= b1;
		b1Delayed1 <= b1Delayed0;
		b1Delayed2 <= b1Delayed1;
		//디바운싱, 엣지 검출 end
		
		if(run == 1'b1)
		begin
			clk100hz <= clk100hz + 20'h0_0001;
			if(clk100hz >= 20'h3_0D40) //실제 돌릴때 30D40, 시뮬레이션 4E20, 0.2초마다
			begin
				clk100hz <= 20'h0_0000;
			
				case (ledState[2:0])
					3'h0:
					begin
						led <= 4'b0001;
						ledState <= 3'h1;
					end
					3'h1:
					begin
						led <= 4'b0011;
						ledState <= 3'h2;
					end
					3'h2:
					begin	
						led <= 4'b0111;
						ledState <= 3'h3;
					end
					3'h3:
					begin
						led <= 4'b1111;
						ledState <= 3'h4;
					end
					default:
					begin
						led <= 4'b0000;
						ledState <= 3'h0;
					end
				endcase
			end
		end
		else
		begin
			if(posedgeDetect1)
			begin
				led <= 4'b0000;
				clk100hz <= 20'h0_0000;
				ledState <= 3'h0;
			end
		end
	end
end

endmodule