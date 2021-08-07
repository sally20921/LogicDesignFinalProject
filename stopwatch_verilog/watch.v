module watch
(
	input mclk,
	
	input b0,
	input b1,
	input b2,
	input reset,
		
	output [6:0] segMin1, //분단위 10자리 수
	output [6:0] segMin2, //분단위 1자리 수
	
	output [6:0] segSec1, //초단위 10자리 수
	output [6:0] segSec2, //초단위 1자리 수
	
	output [6:0] segmil1, //0.1초 
	output [6:0] segmil2, //0.01초
	
	output [3:0] led
);

wire runState;
wire b1Posedge;
wire b2Posedge;
wire resetAll;

wire resetin;
assign resetin = ~reset;

buttonStateMachine bsm(	.mclk(mclk), .b0(b0), .b1(b1), .b2(b2), .reset(resetin)
						, .run(runState), .b1pos(b1Posedge), .b2pos(b2Posedge), .resetAll(resetAll));


wire [7:0] min; //분
wire [7:0] sec; //초
wire [7:0] mil; //0.01초단위

timer gettimer(	.mclk(mclk), .reset(resetAll)
				, .run(runState), .b1Posedge(b1Posedge)
				, .minute(min), .second(sec), .ms10(mil)); //분, 초, 0.01초 받음

ledbar ledb(.mclk(mclk), .b1(b1Posedge), .reset(resetAll), .run(runState), .led(led));
				
seg7Display seg(.mclk(mclk), .reset(resetAll)
				, .run(runState), .b2Posedge(b2Posedge) //상태정보
				, .min(min), .sec(sec), .mil(mil) //시간 정보
				, .minHigh(segMin1), .minLow(segMin2) //출력할 디스플레이
				, .secHigh(segSec1), .secLow(segSec2)
				, .milHigh(segmil1), .milLow(segmil2));

endmodule