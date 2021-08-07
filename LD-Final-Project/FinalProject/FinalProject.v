`timescale 1ns / 1ps
module FinalProject(
	input CLK, //machine clock (50MHz)
	input reset, //reset button
	input [7:0] instruction, //instruction input
	input showPC,
	input showReg0,
	input showReg1,
	input showReg2,
	input showReg3,
	input [4:0] showData,
	output reg DCLED,
	output [6:0] seg1, 
	output [6:0] seg2,
	output [6:0] seg3, 
	output [6:0] seg4, 
	output [6:0] seg5,
	output [6:0] seg6, //hex segments
	output [7:0] readingAddress, //instruction address output
	output runningLED
	);
	 
	wire contCLK; //controlled Clock (1Hz)
	reg [7:0] regWrite; //regWrite
	reg [7:0] pc; //pc value
	assign readingAddress = pc; 
	reg [7:0] data[31:0]; //data memory
	reg [7:0] registers[3:0]; //4 registers
	reg [5:0] counting;
	reg [7:0] display1 = 8'b00000000;
	reg [7:0] display2 = 8'b00000000;
	eg [7:0] readData;
	wire [4:0] showButton;
	assign showButton = {showReg0, showReg1, showReg2, showReg3, showPC};
	
	FrequencyDivider freqdiv (.CLKin(CLK), .clr(reset), .CLKout(contCLK));
	HextoBCD HBCD1 (.bcd(regWrite[7:4]), .segout(seg1));
	HextoBCD HBCD2 (.bcd(regWrite[3:0]), .segout(seg2));
	HextoBCD HBCD3 (.bcd(display1[7:4]), .segout(seg3));
	HextoBCD HBCD4 (.bcd(display1[3:0]), .segout(seg4));
	HextoBCD HBCD5 (.bcd(display2[7:4]), .segout(seg5));
	HextoBCD HBCD6 (.bcd(display2[3:0]), .segout(seg6));
	 
	initial begin
		pc = 8'b00000000;
		for(counting = 0; counting < 32; counting = counting + 1) begin
			data[counting] = counting[3:0];
		end
	end
	 
	assign runningLED = contCLK;
	 
	always @(showData) begin
		display2 = data[showData];
	end
	 
	always @(showButton) begin
		case(showButton)
			5'b10000 : display1 = registers[0];
			5'b01000 : display1 = registers[1];
			5'b00100 : display1 = registers[2];
			5'b00010 : display1 = registers[3];
			default : display1 = pc;
		endcase
	end
	 
	always @(posedge reset or posedge contCLK) begin
		if(reset == 1'b1) begin //reset
			pc = 8'b00000000;
			for(counting = 0; counting < 4; counting = counting + 1) begin
				registers[counting] = 8'b00000000;
			end
			for(counting = 0; counting < 32; counting = counting + 1) begin
				data[counting] = counting[3:0];
			end
		end	
		else begin
			case(instruction[7:6])
				2'b00 : begin //add
					registers[instruction[1:0]] = registers[instruction[3:2]] + registers[instruction[5:4]];
					regWrite = registers[instruction[1:0]];
					pc = pc + 1;
					DCLED = 1'b1;
				end
				2'b01 : begin //load
					registers[instruction[3:2]] = data[registers[instruction[5:4]] + instruction[1:0]];
					regWrite = registers[instruction[3:2]];
					pc = pc + 1;
					DCLED = 1'b1;
				end
				2'b10 : begin //store
					data[registers[instruction[5:4]] + instruction[1:0]] = registers[instruction[3:2]];
					pc = pc + 1;
					DCLED = 1'b0;
				end
				2'b11 : begin //jump
					case(instruction[1:0])
						2'b00 : pc = pc + 1;
						2'b01 : pc = pc + 2;
						2'b10 : pc = pc - 1;
						2'b11 : pc = pc;
					endcase
					DCLED = 1'b0;
				end
			endcase
		end
	end 
endmodule

