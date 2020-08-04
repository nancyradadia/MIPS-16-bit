`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:55:00 09/03/2019 
// Design Name: 
// Module Name:    Stall_control_block 
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
module Stall_control_block(op,clk,reset,stall,stall_pm
    );
	 input [5:0] op;
	 input clk,reset;
	 output stall;
	 output stall_pm;
	 
	 wire HLT,JUMP,LOAD,q1,q3,q4;
	 
	 assign JUMP = (op[2])&(op[3])&(op[4])&(~op[5])&(~q4);
	 assign LOAD = (~op[5])&(~op[3])&(op[4])&(op[2])&(~q1)&(~op[1])&(~op[0]);
	 assign HLT = (op[0])&(~op[1])&(~op[2])&(~op[3])&(op[4])&(~op[5]);
	
	 assign stall = (HLT)|(JUMP)|(LOAD);
	 
	 DFlipFlop d1(LOAD,clk,reset,q1);
	 DFlipFlop d2(stall,clk,reset,stall_pm);
	 DFlipFlop d3(JUMP,clk,reset,q3);
	 DFlipFlop d4(q3,clk,reset,q4);
endmodule
