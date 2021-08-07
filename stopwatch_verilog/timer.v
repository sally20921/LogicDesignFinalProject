module timer
(
	input mclk,
	input reset,
	
	input run,
	input b1Posedge,
	
	output reg [7:0] minute = 8'b0,
	output reg [7:0] second = 8'b0,
	output reg [7:0] ms10 = 8'b0
);

//디바운싱, 엣지 검출용
reg b1Delayed0 = 1'b0;
reg b1Delayed1 = 1'b0;
reg b1Delayed2 = 1'b0;
wire posedgeDetect1;

//positive edge 감지
assign posedgeDetect1 = ~b1Delayed2 & b1Delayed1;
//positive edge 감지 end

//RESET 상태 저장용
reg resetState = 1'b0;

//분주용
reg [19:0] clk100hz = 20'h0_0000;

always @(posedge mclk)
begin
	if(reset == 1'b1) //리셋신호 처리
	begin
		b1Delayed0 = 1'b0;
		b1Delayed1 = 1'b0;
		b1Delayed2 = 1'b0;
	
		resetState = 1'b0;
		
		clk100hz = 20'h0_0000;
	
		minute[7:0] <= 8'b0000_0000;
		second[7:0] <= 8'b0000_0000;
		ms10[7:0] <= 8'b0000_0000;
	end
	else
	begin
		//디바운싱, 엣지 검출
		b1Delayed0 <= b1Posedge;
		b1Delayed1 <= b1Delayed0;
		b1Delayed2 <= b1Delayed1;
		//디바운싱, 엣지 검출 end
		if((run == 1'b0) && posedgeDetect1)
		begin
			resetState <= 1'b1;
		end
	
		if((run == 1'b0) && (resetState == 1'b1)) //RESET상태일 경우
		begin
			minute[7:0] <= 8'b0000_0000;
			second[7:0] <= 8'b0000_0000;
			ms10[7:0] <= 8'b0000_0000;
			resetState <= 1'b0;
			clk100hz <= 20'h0_0000;
		end
		else if(run == 1'b1)//RUN 상태에서
		begin
			clk100hz <= clk100hz + 20'h0_0001;
			if(clk100hz >= 20'h0_2710) //실제 돌릴때 2710, 시뮬레이션 3E8, 0.01초마다
			begin
				clk100hz <= 20'h0_0000;
				if(minute == 8'b0110_0100) //100
				begin
					minute[7:0] <= 8'b0000_0000;
				end
				
				if(second == 8'b0011_1100) //60
				begin
					minute[7:0] <= minute[7:0] + 8'b1;
					second[7:0] <= 8'b0000_0000;
				end
				
				if(ms10 == 8'b0110_0011) //99
				begin
					second[7:0] <= second[7:0] + 8'b1;
					ms10[7:0] <= 8'b0000_0000;
				end
				else
				begin
					ms10[7:0] <= ms10[7:0] + 8'b1;
				end
			end
		end
	end
end

endmodule