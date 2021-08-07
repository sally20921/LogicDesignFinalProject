module buttonStateMachine
(
	input mclk,
	
	input b0,
	input b1,
	input b2,
	input reset,
	
	output run,
	
	output b1pos,
	output b2pos,
	output resetAll
);

//버튼 시간지연을 이용한 디바운싱, positive edge 감지

reg b0Delayed0 = 1'b0;
reg b0Delayed1 = 1'b0;
reg b0Delayed2 = 1'b0;
wire posedgeDetect0;

reg rsDelayed0 = 1'b0;
reg rsDelayed1 = 1'b0;
reg rsDelayed2 = 1'b0;
wire posedgeDetectrs;

//디바운싱
always @(posedge mclk)
begin
	rsDelayed0 <= reset;
	rsDelayed1 <= rsDelayed0;
	rsDelayed2 <= rsDelayed1;
	
	if(rsDelayed2 == 1'b1)
	begin
		b0Delayed0 <= 1'b0;
		b0Delayed1 <= 1'b0;
		b0Delayed2 <= 1'b0;
	end
	else
	begin
		b0Delayed0 <= b0;
		b0Delayed1 <= b0Delayed0;
		b0Delayed2 <= b0Delayed1;
	end
end
//디바운싱 end

//positive edge 감지
assign posedgeDetect0 = ~b0Delayed2 & b0Delayed1;
//positive edge 감지 end

//나머지 버튼은 그대로 출력
assign b1pos = b1;
assign b2pos = b2;

//버튼 시간지연을 이용한 디바운싱, positive edge 감지 end

reg runState = 1'b0;

always @(posedge mclk)
begin
	if(rsDelayed2 == 1'b1)
	begin
		runState <= 1'b0;
	end
	else
	begin
		if(posedgeDetect0) //RUN, STOP 상태 결정
		begin
			runState <= ~runState;
		end
	end
end

assign run = runState; //RUN STOP 상태 토글되서 출력
assign resetAll = rsDelayed2; //디바운싱 되서 모두 리셋 출력

endmodule