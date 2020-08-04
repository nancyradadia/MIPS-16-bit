`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:28:13 09/03/2019 
// Design Name: 
// Module Name:    Back_Block 
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
module Back_Block(ans_dm,clk,reset,ans_wb
    );
	 
	 input [15:0] ans_dm;
	 input clk,reset;
	 output reg [15:0] ans_wb;
	 
	 always@(posedge clk)
	 begin
		ans_wb = (!reset) ? 16'b0000000000000000 : ans_dm;
	 end

endmodule
