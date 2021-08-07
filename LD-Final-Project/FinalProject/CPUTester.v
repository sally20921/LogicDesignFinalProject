`timescale 1ns / 1ps
module CPUTester;
	// Inputs
	reg CLK;
	reg reset;
	wire [7:0] instruction;
	reg showPC;
	reg showReg0;
	reg showReg1;
	reg showReg2;
	reg showReg3;
	reg [4:0] showData;

	// Outputs
	wire DCLED;
	wire [6:0] seg1;
	wire [6:0] seg2;
	wire [6:0] seg3;
	wire [6:0] seg4;
	wire [6:0] seg5;
	wire [6:0] seg6;
	wire [7:0] readingAddress;
	wire runningLED;
	wire [7:0] MemByte[20:0];
	
	assign MemByte[0] = 8'b01000100;
	assign MemByte[1] = 8'b01001001;
	assign MemByte[2] = 8'b00011001;
	assign MemByte[3] = 8'b10000100;
	assign MemByte[4] = 8'b01000100;
	assign MemByte[5] = 8'b01001001;
	assign MemByte[6] = 8'b00011001;
	assign MemByte[7] = 8'b10000100;
	assign MemByte[8] = 8'b01000100;
	assign MemByte[9] = 8'b01001001;
	assign MemByte[10] = 8'b00011001;
	assign MemByte[11] = 8'b10000100;
	assign MemByte[12] = 8'b01000100;
	assign MemByte[13] = 8'b01001001;
	assign MemByte[14] = 8'b00011001;
	assign MemByte[15] = 8'b10000100;
	assign MemByte[16] = 8'b01000100;
	assign MemByte[17] = 8'b01001001;
	assign MemByte[18] = 8'b00011001;
	assign MemByte[19] = 8'b10000100;
	assign MemByte[20] = 8'b11000011;
	assign instruction = MemByte[readingAddress];
	
	// Instantiate the Unit Under Test (UUT)
	FinalProject uut ( .CLK(CLK), .reset(reset), .instruction(instruction), .showPC(showPC), 
		.showReg0(showReg0), .showReg1(showReg1), .showReg2(showReg2), .showReg3(showReg3), .showData(showData), 
		.seg1(seg1), .seg2(seg2), .seg3(seg3), .seg4(seg4), .seg5(seg5), .seg6(seg6), 
		.readingAddress(readingAddress), .runningLED(runningLED), .DCLED(DCLED), 
	);

	initial begin
		CLK = 0;
		reset = 1;
		#50;
		reset = 0;
	end
	always #10
		CLK = ~CLK;
endmodule

