`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:47:38 08/20/2019 
// Design Name: 
// Module Name:    PROGRAM_MEMORY 
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
module PROGRAM_MEMORY(jump_loc,clk, pc_mux_sel,stall,stall_pm,reset,ins,current_address);
	
	 
	 input [15:0] jump_loc;
	 input clk;
	 input  pc_mux_sel,stall,stall_pm,reset;
	 output [31:0] ins;
	 output [15:0] current_address;
	 wire [31:0] PM_out;
	 
	 wire [15:0]CAJ,CAR;				// temp1 = next_address, temp2 = hold_address
	 wire [31:0]ins_pm,ins;
	 reg [31:0]ins_prv;	 
	 reg [15:0] next_add, hold_add;
	 
	assign CAJ = (stall) ? hold_add : next_add;		// CAJ = next_add when stall==1, else CAJ = hold_add (ultimmate use of multiplexer)
	assign CAR = (pc_mux_sel) ? jump_loc : CAJ;    //  CAR is 16 bit address 
	assign current_address = (reset==0) ? 16'b0000000000000000 : CAR;  // adrress becomes 0 at reset = 0 
	assign ins_pm = (stall_pm) ? ins_prv : PM_out;
	assign ins = (reset) ? ins_pm : 32'b00000000000000000000000000000000; 
	 
	
	P_MODULE PM (
  .clka(clk), // input clka
  .addra(current_address), // input [15 : 0] addra
  .douta(PM_out) // output [31 : 0] douta
   );
	
	
	always@(posedge clk or negedge reset)
	begin
			 next_add <= (!reset) ? 16'b0000000000000000 :(current_address + 16'b0000000000000001);				// storing the next_address in register
			 hold_add <= (!reset) ? 16'b0000000000000000 : (current_address);				
		    ins_prv <= (!reset) ?  32'b00000000000000000000000000000000 : ins ;					// storing ins_pm in register		
	end
	
 

endmodule
