`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:22:18 09/10/2019
// Design Name:   Jump_Control
// Module Name:   D:/efi/IET work/SEM3PROGRAM2/Jump_control_testing.v
// Project Name:  SEM3PROGRAM2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Jump_Control
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Jump_control_testing;

	// Inputs
	reg [15:0] jmp_address_pm;
	reg [15:0] current_address;
	reg [5:0] op;
	reg [1:0] flag_ex;
	reg interrupt;
	reg clk;
	reg reset;

	// Outputs
	wire [15:0] jmp_loc;
	wire pc_mux_sel;

	// Instantiate the Unit Under Test (UUT)
	Jump_Control uut (
		.jmp_address_pm(jmp_address_pm), 
		.current_address(current_address), 
		.op(op), 
		.flag_ex(flag_ex), 
		.interrupt(interrupt), 
		.clk(clk), 
		.reset(reset), 
		.jmp_loc(jmp_loc), 
		.pc_mux_sel(pc_mux_sel)
	);

	initial begin
		// Initialize Inputs
		jmp_address_pm =  16'b0000000000000000;
		current_address = 16'b0000000000000001;
		op = 6'b000000;
		flag_ex = 2'b11;
		interrupt = 0;
		clk = 0;
		reset = 1;

		// Wait 100 ns for global reset to finish
		#2;
		reset =0;
		#6;
		reset = 1;
		#8;
		interrupt = 1;
		
		#10;
		interrupt = 0;
		jmp_address_pm = 16'b0000000000001000;
		#10;
		op = 6'b011000;
		#20;
		op = 6'b010000;
		flag_ex = 2'b00;
		#10;
		op = 6'b011110;
        
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

