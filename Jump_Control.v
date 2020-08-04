`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:01:02 09/10/2019 
// Design Name: 
// Module Name:    Jump_Control 
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

module Jump_Control(jmp_address_pm,current_address,op_dec,flag_ex,interrupt,clk,reset,jmp_loc,pc_mux_sel
    );
	 
	 
input [15:0] jmp_address_pm,current_address;
input [5:0] op_dec;
input [1:0] flag_ex;
input clk,reset,interrupt;
output [15:0] jmp_loc;
output pc_mux_sel;

wire JV,JNV,JZ,JNZ,JMP,RET;
wire q1,q2,and1,and2,and3,and4;
wire [15:0] mux1,mux2,mux3;
wire [1:0] mux4,mux5;
reg [1:0] regmux4;
reg [15:0] regmux1;

assign JV  = (~op_dec[0]) & (~op_dec[1]) & (op_dec[2]) & (op_dec[3]) & (op_dec[4]) & (~op_dec[5]);
assign JNV = (op_dec[0]) & (~op_dec[1]) & (op_dec[2]) & (op_dec[3]) & (op_dec[4]) & (~op_dec[5]);
assign JZ  = (~op_dec[0]) & (op_dec[1]) & (op_dec[2]) & (op_dec[3]) & (op_dec[4]) & (~op_dec[5]);
assign JNZ  = (op_dec[0]) & (op_dec[1]) & (op_dec[2]) & (op_dec[3]) & (op_dec[4]) & (~op_dec[5]);
assign JMP = (~op_dec[0]) & (~op_dec[1]) & (~op_dec[2]) & (op_dec[3]) & (op_dec[4]) & (~op_dec[5]);
assign RET = (~op_dec[0]) & (~op_dec[1]) & (~op_dec[2]) & (~op_dec[3]) & (op_dec[4]) & (~op_dec[5]);

DFlipFlop d1(interrupt,clk,reset,q1);
DFlipFlop d2(q1,clk,reset,q2);

assign mux1 = (interrupt==1'b0) ? regmux1 : current_address + 16'h0001;
assign mux2 = (q1==1'b0)  ? jmp_address_pm : 16'hF000;
assign mux3 = (RET==1'b0) ? mux2 : regmux1;
assign mux4 = (q2==1'b0)  ? regmux4 : flag_ex;
assign mux5 = (RET==1'b0) ? flag_ex : regmux4;

assign and1 = JV  &  mux5[0];
assign and2 = JNV & ~mux5[0];
assign and3 = JZ  &  mux5[1];
assign and4 = JNZ & ~mux5[1];

assign pc_mux_sel = and1 | and2 | and3 | and4 | JMP | RET | q1;
assign jmp_loc = mux3;

always@(posedge clk or negedge reset)
begin
regmux1 <= (reset==1'b0) ?  16'h0000 : mux1;
regmux4 <= (reset==1'b0) ? 2'b00 : mux4;
end

endmodule

	 
	 
	 
/*	 
input [15:0] jmp_address_pm,current_address; //jump address form instruction memory(pm block)
input [5:0] op;
input [1:0] flag_ex;
input clk,reset,interrupt; //interrupt is a 1 bit value to allow interrupt or not.

output [15:0] jmp_loc; //jump location or Jump address for PC_IM block
output pc_mux_sel;//Mux selection bit for PC_IM block

wire JV,JNV,JZ,JNZ,JMP,RET; //this are the outputs of different AND gates of different opcodes for jumps.

assign JV = (~op[5] & op[4] & op[3] & op[2] & ~op[1] & ~op[0]) ; //jump with overflow
assign JNV = (~op[5] & op[4] & op[3] & op[2] & ~op[1] & op[0]) ; //jump with No Overflow
assign JZ = (~op[5] & op[4] & op[3] & op[2] & op[1] & ~op[0]) ; // jump with Zero
assign JNZ = (~op[5] & op[4] & op[3] & op[2] & op[1] & op[0]) ;// jump with NO Zero
assign JMP = (~op[5] & op[4] & op[3] & ~op[2] & ~op[1] & ~op[0] ); // Unconditional jump
assign RET = (~op[5] & op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0]) ; 


wire q1,q2;
reg int_1,int_2;  // Outputs of DFF // DFF is used to create delay of 2 clock cycle.

wire [15:0] jmp_mux; // output of mux to choose between f000 or jmp_address_pm.

assign jmp_mux = (q1) ?  16'b1111000000000000 : jmp_address_pm ;

wire [15:0] add;
assign add = current_address +16'b0000000000000001;

wire [15:0] input_reg_16bit,input_reg_16bit_tmp; // reg wires taken to check reset cond* and use to that 16 bit register.
reg [15:0] output_reg_16bit;

DFlipFlop d1(interrupt,clk,reset,q1);
DFlipFlop d2(q1,clk,reset,q2);

wire [15:0] jump_loc_mux; // this mux is used to choose between output_reg_16bit and jmp_mux.
assign jmp_loc = (RET) ? output_reg_16bit : jmp_mux;

wire[1:0] input_reg_2bit ,input_reg_2bit_tmp ; //reg wires taken to check reset cond* and use to that 2 bit register.
reg [1:0] output_reg_2bit;

assign input_reg_2bit = (q2) ? flag_ex: output_reg_2bit;
assign input_reg_2bit_tmp = (reset) ? input_reg_2bit : 2'b00 ;

wire [1:0] selection; // this selection line is used to compute four conditional jumps.
assign selection = (RET) ? output_reg_2bit : flag_ex ;

wire jv1,jnv1,jz1,jnz1;
assign jv1 = JV & selection[0] ;
assign jnv1 = JNV & ~selection[0];
assign jz1 = JZ & selection[1] ;
assign jnz1 = JNZ & selection[1];

assign pc_mux_sel = jv1 | jnv1 | jz1 | jnz1 | JMP | RET | q1 ; 
always@(posedge clk)
begin
	output_reg_16bit = input_reg_16bit_tmp;	
	output_reg_2bit = input_reg_2bit_tmp;
end
endmodule
*/
