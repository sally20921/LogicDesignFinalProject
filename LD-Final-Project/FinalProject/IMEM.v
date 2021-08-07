`timescale 1ns / 1ps

module IMEM(
    output [7:0] Instruction,
    input [7:0] Read_Address
    );
	 
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

	 assign Instruction = MemByte[Read_Address];

endmodule
