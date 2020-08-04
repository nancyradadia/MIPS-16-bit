`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:23:23 08/26/2019
// Design Name:   PROGRAM_MEMORY
// Module Name:   D:/efi/IET work/SEM3PROGRAM2/ProgramMemory_testing.v
// Project Name:  SEM3PROGRAM2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: PROGRAM_MEMORY
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ProgramMemory_testing;

	// Inputs
	reg [15:0] jump_loc;
	reg clk;
	reg pc_mux_sel;
	reg stall;
	reg stall_pm;
	reg reset;

	// Outputs
	wire [31:0] ins;
	wire [15:0] current_address;

	// Instantiate the Unit Under Test (UUT)
	PROGRAM_MEMORY uut (
		.jump_loc(jump_loc), 
		.clk(clk), 
		.pc_mux_sel(pc_mux_sel), 
		.stall(stall), 
		.stall_pm(stall_pm), 
		.reset(reset), 
		.ins(ins), 
		.current_address(current_address)
	);

	initial begin
		// Initialize Inputs
	/*		jump_loc = 16'b0000000000001000;
		
		pc_mux_sel = 1;
		stall = 0;
		stall_pm = 0;
		reset = 1;

		// Wait 100 ns for global reset to finish
		#2;
		
		
		jump_loc = 16'b0000000000001000;
		pc_mux_sel = 1;
		stall = 0;
		stall_pm = 0;
		reset = 0;

		// Wait 100 ns for global reset to finish
		#6;
		
		jump_loc = 16'b0000000000001000;				//3
		pc_mux_sel = 1;
		stall = 0;
		stall_pm = 0;
		reset = 1;
		
		#2;
		pc_mux_sel = 0;			//4
		stall = 0;
		stall_pm = 0;
		
		#5;
		
		pc_mux_sel = 1;
		stall = 0;
		stall_pm = 0;
		
		#10;
		
		pc_mux_sel = 1;		//6
		stall = 0;
		stall_pm = 0;
		
		#10;
		pc_mux_sel = 1;		//7
		stall = 0;
		stall_pm = 0;
		
		#10;
		
		pc_mux_sel = 0;
		stall = 1;
		stall_pm = 0;			//8
		
		#10;
		
		pc_mux_sel = 0;
		stall = 0;
		stall_pm = 1;
		
		#5;
		
		pc_mux_sel = 0;		//10
		stall = 0;
		stall_pm = 1;
		
		#5;
		
		pc_mux_sel = 1;
		stall = 0;
		stall_pm = 0;
		
		#5;
		
		pc_mux_sel = 1;
		stall = 0;
		stall_pm = 0;
        
		// Add stimulus here */
		
	   jump_loc = 4'h0008;		
		pc_mux_sel = 1;
		stall = 0;
		stall_pm = 0;
		reset = 1;
		
		#2;
		reset = 0;
		#6;
		reset = 1;
		#2;
		pc_mux_sel = 0;
		#30;
		stall = 1;
		#10;
		stall_pm = 1;
		stall = 0;
		#10;
		stall_pm = 0;
		pc_mux_sel = 1;
		#5;
		

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

