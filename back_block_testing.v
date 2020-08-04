`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:53:46 09/03/2019
// Design Name:   Back_Block
// Module Name:   D:/efi/IET work/SEM3PROGRAM2/back_block_testing.v
// Project Name:  SEM3PROGRAM2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Back_Block
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module back_block_testing;

	// Inputs
	reg [15:0] ans_dm;
	reg clk;
	reg reset;

	// Outputs
	wire [15:0] ans_wb;

	// Instantiate the Unit Under Test (UUT)
	Back_Block uut (
		.ans_dm(ans_dm), 
		.clk(clk), 
		.reset(reset), 
		.ans_wb(ans_wb)
	);

	initial begin
		// Initialize Inputs
		ans_dm = 0;
		clk = 0;
		reset = 0;

		// Wait 100 ns for global reset to finish
		#10;
		
		ans_dm = 16'b0000000000000011;
		reset = 1;
		#10;
			ans_dm = 16'b0000000000100011;
		reset = 1;
		
        
		// Add stimulus here

	end
	initial begin
		clk = 0;
		forever
		begin
			#5;
			clk = ~clk;
		end
        
		// Add stimulus here

	end
      
endmodule

