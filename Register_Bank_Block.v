`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:52:58 08/27/2019 
// Design Name: 
// Module Name:    Register_Bank_Block 
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
module Register_Bank_Block(ans_ex,ans_wb,imm,mux_sel_A,mux_sel_B,imm_sel,RA,RB,RW_dm,clk,ans_dm,A,B
    );
	 
input [4:0] RA,RB,RW_dm;
input clk,imm_sel;
input[1:0]mux_sel_A,mux_sel_B;
input [15:0] ans_dm,ans_ex,ans_wb,imm;
output [15:0]A,B;
reg [15:0] AR,BR;
wire [15:0] BI;

reg [15:0] register [31:0];  //creating register bank using 2D array

always@(posedge clk)
begin
	register[RW_dm]<=ans_dm;            // assigning value of ans_dm in register
	AR <= register[RA];  //fetching value at address RA
	BR <= register[RB];  //fetching value at address RB

end



assign A = (mux_sel_A==2'b00)?AR:(mux_sel_A==2'b01)?ans_ex:(mux_sel_A==2'b10)?ans_dm:(mux_sel_A==2'b11)?ans_wb:1'b0;//multiplexer for selecting A
assign BI = (mux_sel_B==2'b00)?BR:(mux_sel_B==2'b01)?ans_ex:(mux_sel_B==2'b10)?ans_dm:(mux_sel_B==2'b11)?ans_wb:1'b0;   //multiplexer for selecting BI

assign B = (imm_sel==0)?BI:imm; //multiplexer for selecting B or imm

endmodule

