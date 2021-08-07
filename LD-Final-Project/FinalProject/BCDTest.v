`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:54:16 06/15/2018
// Design Name:   HextoBCD
// Module Name:   /csehome/calofmijuck/LDFP/BCDTest.v
// Project Name:  LDFP
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: HextoBCD
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module BCDTest;

	// Inputs
	reg [3:0] bcd;

	// Outputs
	wire [6:0] segout;

	// Instantiate the Unit Under Test (UUT)
	HextoBCD uut (
		.bcd(bcd), 
		.segout(segout)
	);

	initial begin
		// Initialize Inputs
		bcd = 0;
		#50;
		bcd = 1;
		#50;
		bcd = 2;
		#50;
		bcd = 3;
		#50;
		bcd = 4;
		#50;
		bcd = 5;
		#50;
		bcd = 6;
		#50;
		bcd = 7;
		#50;
		bcd = 8;
		#50;
		bcd = 9;
		#50;
		bcd = 10;
		#50;
		bcd = 11;
		#50;
		bcd = 12;
		#50;
		bcd = 13;
		#50;
		bcd = 14;
		#50;
		bcd = 15;
		#50;
		bcd = 0;

      
		
		// Add stimulus here

	end
      
endmodule

