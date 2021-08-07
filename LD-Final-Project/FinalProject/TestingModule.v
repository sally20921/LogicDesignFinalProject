`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:05:07 06/13/2018 
// Design Name: 
// Module Name:    TestingModule 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module TestingModule(
    input [7:0] Read_Address,
    output [7:0] Instruction
    );
	 
	 wire [7:0] MemByte[5:0]; //
	 
	 // OPERATION TEST SET //
	 // lw $s1, 0($s0)s
	 assign MemByte[0] = { 2'b01, 2'b00, 2'b01, 2'b00 };

	 // lw $s2, 1($s0)
 	 assign MemByte[1] = { 2'b01, 2'b00, 2'b10, 2'b01 };

	 // add $s0, $s1, $s2
	 assign MemByte[2] = { 2'b00, 2'b01, 2'b10, 2'b00 };
	
	 // sw $s2, 1($s0)
	 assign MemByte[3] = { 2'b10, 2'b00, 2'b10, 2'b01 };
	 
	 // j -1
	 assign MemByte[4] = { 2'b11, 4'b0000, 2'b11 };

	 // Assign address
	 assign Instruction = MemByte[Read_Address];


endmodule