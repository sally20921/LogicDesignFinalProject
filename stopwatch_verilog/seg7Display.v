module seg7Display
(
	input mclk,
	input reset,
	
	input run,
	input b2Posedge,
	
	input [7:0] min, //분
	input [7:0] sec, //초
	input [7:0] mil, //0.01초단위
	
	output [6:0] minHigh, //분단위 10자리 수
	output [6:0] minLow, //분단위 1자리 수
	
	output [6:0] secHigh, //초단위 10자리 수
	output [6:0] secLow, //초단위 1자리 수
	
	output [6:0] milHigh, //0.1초 
	output [6:0] milLow //0.01초
);

reg laptimeState = 1'b0; //상태 저장용
reg [7:0] minBuf = 8'b0000_0000; //분 단위 한번 저장용
reg [7:0] secBuf = 8'b0000_0000; //초 단위 한번 저장용
reg [7:0] milBuf = 8'b0000_0000; //0.01초 단위 한번 저장용

//최종 출력용
reg [7:0] outputMin = 8'b0000_0000;
reg [7:0] outputSec = 8'b0000_0000;
reg [7:0] outputMil = 8'b0000_0000;

//디바운싱, 엣지 검출용
reg b2Delayed0 = 1'b0;
reg b2Delayed1 = 1'b0;
reg b2Delayed2 = 1'b0;
wire posedgeDetect2;

//positive edge 감지
assign posedgeDetect2 = ~b2Delayed2 & b2Delayed1;
//positive edge 감지 end

always @(posedge mclk)
begin
	if(reset == 1'b1)
	begin
		laptimeState = 1'b0; //상태 저장용
		minBuf = 8'b0000_0000; //분 단위 한번 저장용
		secBuf = 8'b0000_0000; //초 단위 한번 저장용
		milBuf = 8'b0000_0000; //0.01초 단위 한번 저장용

		//최종 출력용
		outputMin = 8'b0000_0000;
		outputSec = 8'b0000_0000;
		outputMil = 8'b0000_0000;

		//디바운싱, 엣지 검출용
		b2Delayed0 = 1'b0;
		b2Delayed1 = 1'b0;
		b2Delayed2 = 1'b0;
	end
	else
	begin
		//디바운싱, 엣지 검출
		b2Delayed0 <= b2Posedge;
		b2Delayed1 <= b2Delayed0;
		b2Delayed2 <= b2Delayed1;
		//디바운싱, 엣지 검출 end
		if(posedgeDetect2 && (run == 1'b1))
		begin
			laptimeState = 1'b1;
			minBuf[7:0] <= min[7:0];
			secBuf[7:0] <= sec[7:0];
			milBuf[7:0] <= mil[7:0];
		end
		if((run == 1'b1) && (laptimeState == 1'b1)) //버퍼에 한번 저장된 시간 출력
		begin
			outputMin[7:0] <= minBuf[7:0];
			outputSec[7:0] <= secBuf[7:0];
			outputMil[7:0] <= milBuf[7:0];
		end
		else if(run == 1'b0) //RUN상태가 아니면 LAPTIME 상태 초기화, 시간 그대로 출력
		begin
			laptimeState <= 1'b0;
			outputMin[7:0] <= min[7:0];
			outputSec[7:0] <= sec[7:0];
			outputMil[7:0] <= mil[7:0];
		end
		else //그 이외에는 시간 그대로 출력만 함
		begin
			outputMin[7:0] <= min[7:0];
			outputSec[7:0] <= sec[7:0];
			outputMil[7:0] <= mil[7:0];
		end
	end
end

seg7dec2 minseg(.val(outputMin), .highDigit(minHigh), .lowDigit(minLow)); //분단위 출력
seg7dec2 secseg(.val(outputSec), .highDigit(secHigh), .lowDigit(secLow)); //초단위 출력
seg7dec2 milseg(.val(outputMil), .highDigit(milHigh), .lowDigit(milLow)); //0.01초단위 출력

endmodule