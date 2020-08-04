`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    13:03:41 10/03/2019
// Design Name:
// Module Name:    dependency_check_block
// Project Name:
// Target Devices:
// Tool versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File // Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////
module Dependency_Check_Block_2(ins, clk, reset, imm, op_dec, RW_dm, mux_sel_A, mux_sel_B, imm_sel, mem_en_ex, mem_rw_ex, mem_mux_sel_dm
);

input [31:0] ins;
input clk,reset;
output reg [15:0] imm;
output reg [5:0] op_dec;
output [4:0] RW_dm;
output [1:0] mux_sel_A,mux_sel_B;
output imm_sel,mem_en_ex,mem_rw_ex,mem_mux_sel_dm;

wire JMP,COND_J,LD_FB,LD1,ST,IMM;
wire Q1,Q2,Q3,Q4,Q7;
wire [14:0] input_extend,and01;
wire and1,and2,and3,and4;
reg [4:0] reg1,reg2,reg3,reg4,reg5,reg6;
wire comp1,comp2,comp3,comp4,comp5,comp6;

assign JMP = (~ins[26]) & (~ins[27]) & (~ins[28]) & (ins[29]) & (ins[30]) & (~ins[31]);
assign COND_J = (ins[28]) & (ins[29]) & (ins[30]) & (~ins[31]);
assign LD_FB = (~ins[26]) & (~ins[27]) & (ins[28]) & (~ins[29]) & (ins[30]) & (~ins[31]) & (~Q1);
assign LD1 = (~ins[26]) & (~ins[27]) & (ins[28]) & (~ins[29]) & (ins[30]) & (~ins[31]);
assign ST = (ins[26]) & (~ins[27]) & (ins[28]) & (~ins[29]) & (ins[30]) & (~ins[31]);
assign IMM = (ins[29]) & (~ins[30]) & (~ins[31]);

DFlipFlop d1(LD_FB, clk, reset, Q1);
DFlipFlop d2(ins[26], clk, reset, Q2);
DFlipFlop d3(LD1 & (~Q3), clk, reset, Q3);
DFlipFlop d4(ST, clk, reset, Q4);
DFlipFlop d5(IMM, clk, reset, imm_sel);
DFlipFlop d6(Q2, clk, reset, mem_rw_ex);
DFlipFlop d7((~Q2) & (Q3 | Q4) , clk, reset, Q7);
DFlipFlop d8((Q3 | Q4) , clk, reset, mem_en_ex);
DFlipFlop d9(Q7, clk, reset, mem_mux_sel_dm);

assign input_extend[0] = ~(JMP | COND_J | Q1);
assign input_extend[14:1] = input_extend[0]==1 ? 14'b11111111111111 : 14'b00000000000000;
assign and01 = input_extend[14:0] & ins[25:11];

assign comp1 = (reg4 == reg1) ? 1'b1 : 1'b0;
assign comp2 = (reg5 == reg1) ? 1'b1 : 1'b0;
assign comp3 = (reg6 == reg1) ? 1'b1 : 1'b0;
assign comp4 = (reg4 == reg3) ? 1'b1 : 1'b0;
assign comp5 = (reg5 == reg3) ? 1'b1 : 1'b0;
assign comp6 = (reg6 == reg3) ? 1'b1 : 1'b0;

assign and1 = ~comp1 & comp2;
assign and2 = ~comp1 & ~comp2 & comp3;
assign and3 = ~comp4 & comp5;
assign and4 = ~comp4 & ~comp5 & comp6;

priority_encoder p1(comp1,and1,and2,mux_sel_A);
priority_encoder p2(comp4,and3,and4,mux_sel_B);
assign RW_dm = reg5;

always@(posedge clk)
begin
if(reset)
begin
imm <= ins[15:0];
op_dec <= ins[31:26];
reg1 <= and01[9:5];
reg2 <= and01[14:10];
reg3 <= and01[4:0];
reg4 <= reg2;
reg5 <= reg4;
reg6 <= reg5;
end
else
begin
imm <= 16'b0000000000000000;
op_dec <= 6'b000000;
reg1 <= 5'b00000;
reg2 <= 5'b00000;
reg3 <= 5'b00000;
reg4 <= 5'b00000;
reg5 <= 5'b00000;
reg6 <= 5'b00000;
end

end

endmodule


module priority_encoder(i1,i2,i3,out);

input i1,i2,i3;
output [1:0] out;

assign out[1] = i2 | i3;
assign out[0] = i3 | (i1 & (~i2));

endmodule






















/*`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:59:28 09/30/2019 
// Design Name: 
// Module Name:    Dependency_Check_Block_2 
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
module Dependency_Check_Block_2(ins, clk, reset, imm, op_dec, RW_dm, mux_sel_A, mux_sel_B, imm_sel, mem_en_ex, mem_rw_ex, mem_mux_sel_dm
    );
	 input [31:0] ins;
	 input clk,reset;
	 output [15:0] imm;
    output [5:0] op_dec;
    output [4:0] RW_dm;
	 output [1:0] mux_sel_A, mux_sel_B;
    output  imm_sel, mem_en_ex, mem_rw_ex, mem_mux_sel_dm;
	 
	 wire ST,LD1,Imm,LD_fb,Cond_J,JMP;
	 
	 wire temp_LD_fb;
	 reg temp_LD_fb_reg;
	 assign temp_LD_fb = (reset)? LD_fb : 1'b0;
	  
	 assign ST = (ins[26])&(~ins[27])&(ins[28])&(~ins[29])&(ins[30])&(~ins[31]);
	 assign LD1 = (~ins[26])&(~ins[27])&(ins[28])&(~ins[29])&(ins[30])&(~ins[31]);
	 assign Imm = (ins[29])&(~ins[30])&(~ins[31]);      
	 assign LD_fb = (~ins[26])&(~ins[27])&(ins[28])&(~ins[29])&(ins[30])&(~ins[31]) & (~(temp_LD_fb_reg));
	 assign Cond_J = (ins[28])&(ins[29])&(ins[30])&(~ins[31]);
	 assign JMP = (~ins[26])&(~ins[27])&(~ins[28])&(ins[29])&(ins[30])&(~ins[31]);
	 
	 wire LD_and,temp_LD_and;                               // 2nd last register LD_and (down)
	 reg temp_LD_and_reg;
	 assign LD_and = (LD1)&(~temp_LD_and_reg);
	 assign temp_LD_and = (reset)? LD_and : 1'b0;
	 
	 wire temp_ins26;
	 reg temp_ins26_reg;
	 assign temp_ins26 = (reset) ? ins[26] : 1'b0;  // 1st reg
	 
	 wire temp_st;
	 reg temp_st_reg;
	 assign temp_st = (reset) ? ST : 1'b0;	   // 3rd reg
	 
	 wire LD_ST_OR;
	 assign LD_ST_OR = (temp_st_reg|temp_LD_and_reg);  // OR of LD_ST
	 
	 wire ins26_LDSTor_AND;
	 assign ins26_LDSTor_AND =  ((~temp_ins26_reg)&(LD_ST_OR)); 
	 
	 wire temp_ins26_2;  
	 reg temp_ins26_2_reg;
	 assign temp_ins26_2 = (reset)? temp_ 	ins26_reg : 1'b0;   // register after 1st reg (ins_26)
	 
	
	 assign mem_rw_ex = temp_ins26_2_reg;  // output after 1st register flow ie x1
	 
	 wire temp_ins26_LDSTor_AND;    // flow of 2nd reg
	 reg  temp_ins26_LDSTor_AND_reg;
	 assign temp_ins26_LDSTor_AND = (reset) ? ins26_LDSTor_AND : 1'b0;
	 
	 wire temp_last_2;
	 reg temp_last_2_reg;
	 assign temp_last_2 = (reset) ? temp_ins26_LDSTor_AND_reg : 1'b0;  
	 assign mem_mux_sel_dm =  temp_last_2_reg;       // 2nd output x1
	 
	 wire temp_LD_ST_OR;
	 reg temp_LD_ST_OR_reg;
	 assign temp_LD_ST_OR = (reset) ? LD_ST_OR : 1'b0;
	 assign mem_en_ex = temp_LD_ST_OR_reg;          // 3rd output x1
	 
	 wire temp_Imm;
	 reg temp_Imm_reg;
	 assign temp_Imm = (reset) ? Imm : 1'b0;
	 assign imm_sel = temp_Imm_reg;       // output before 1st (imm_sel)
	 
	 wire jump_LD_fb_OR;
	 assign jump_LD_fb_OR = (~(JMP | Cond_J | temp_LD_fb_reg));  // NOR of JMP, con_jmp, LD_JMP
	 
	 wire[14:0] input_extend;
	 assign input_extend = (jump_LD_fb_OR==1) ? 15'b111111111111111 : 15'b000000000000000;  // input extend 15 bits
	 
	 wire [14:0] ins_inputExtend_AND;
	 assign ins_inputExtend_AND = (ins[25:11] & input_extend);  // and block of ins and input extend
	 
	 // 6 registers of ins_and extend
	 
	 wire [4:0] temp1_ins_extend_and;
	 reg [4:0] temp1_ins_extend_and_reg;	 
	 assign temp1_ins_extend_and = (reset==1)? (ins_inputExtend_AND[9:5]) : 5'b00000;
	 
	 wire [4:0] temp2_ins_extend_and;
	 reg [4:0] temp2_ins_extend_and_reg;	 
	 assign  temp2_ins_extend_and = (reset)? (ins_inputExtend_AND[14:10]) : 5'b00000;
	  
	 wire [4:0] temp3_ins_extend_and;
	 reg [4:0] temp3_ins_extend_and_reg;	 
	 assign  temp3_ins_extend_and = (reset)? temp2_ins_extend_and_reg : 5'b00000;
	  
	 wire [4:0] temp4_ins_extend_and;
	 reg [4:0] temp4_ins_extend_and_reg;	 
	 assign  temp4_ins_extend_and = (reset)? temp3_ins_extend_and_reg:5'b00000;
	 
	 wire [4:0] temp5_ins_extend_and;
	 reg [4:0] temp5_ins_extend_and_reg;	 
	 assign  temp5_ins_extend_and = (reset)? temp4_ins_extend_and_reg: 5'b00000;
	 
	 wire [4:0] temp6_ins_extend_and;
	 reg [4:0] temp6_ins_extend_and_reg;	 
	 assign  temp6_ins_extend_and = (reset)? (ins_inputExtend_AND[4:0]) : 5'b00000;
	 
	 assign RW_dm = temp4_ins_extend_and_reg;  // output RW(2)
	 
	 always@(posedge clk)
	 begin
	 
	 temp_LD_fb_reg <= temp_LD_fb;
	 temp_LD_and_reg <= temp_LD_and;
	 temp_ins26_reg <= temp_ins26;
	 temp_st_reg <= temp_st;
	 temp_ins26_2_reg <= temp_ins26_2;
	 temp_ins26_LDSTor_AND_reg <= temp_ins26_LDSTor_AND;
	 temp_last_2_reg <= temp_last_2;
	 temp_LD_ST_OR_reg <= temp_LD_ST_OR;
	 temp_Imm_reg <= temp_Imm;
	 
	 temp1_ins_extend_and_reg <= temp1_ins_extend_and;
	 temp2_ins_extend_and_reg <= temp2_ins_extend_and;
	 temp3_ins_extend_and_reg <= temp3_ins_extend_and;
	 temp4_ins_extend_and_reg <= temp4_ins_extend_and;
	 temp5_ins_extend_and_reg <= temp5_ins_extend_and;
	 temp6_ins_extend_and_reg <= temp6_ins_extend_and;
	 
	 temp_ins26_31_reg <= temp_ins26_31;
	 temp_ins32_reg <= temp_ins32;
	 	 	 
	 end	
		
	 //comparators
	 wire comp1,comp2,comp3,comp4,comp5,comp6;
	 
	 assign comp1 = (temp1_ins_extend_and_reg == temp3_ins_extend_and_reg) ? 1'b1 :1'b0;
	 assign comp2 = (temp1_ins_extend_and_reg == temp4_ins_extend_and_reg) ? 1'b1 :1'b0;
	 assign comp3 = (temp1_ins_extend_and_reg == temp5_ins_extend_and_reg) ? 1'b1 :1'b0;
	 assign comp4 = (temp3_ins_extend_and_reg == temp6_ins_extend_and_reg) ? 1'b1 :1'b0;
	 assign comp5 = (temp4_ins_extend_and_reg == temp6_ins_extend_and_reg) ? 1'b1 :1'b0;
	 assign comp6 = (temp5_ins_extend_and_reg == temp6_ins_extend_and_reg) ? 1'b1 :1'b0;
	 
	 wire comp12_AND, comp123_AND, comp45_AND, comp456_AND;
	 assign comp12_AND = (~comp1 & comp2);
	 assign comp123_AND = (~comp1 & ~comp2 & comp3);
    assign comp45_AND = (~comp4 & comp5);
    assign comp456_AND = (~comp4 & ~comp5 & comp6);
    
    assign mux_sel_A = (comp1==1) ? 2'b01 : (comp12_AND==1) ? 2'b10 : (comp123_AND==1) ? 2'b11 : 2'b00; // final output  
	 assign mux_sel_B = (comp4==1) ? 2'b01 : ( comp45_AND==1) ? 2'b10 : (comp456_AND==1) ? 2'b11 : 2'b00;	
	 
	  wire [5:0] temp_ins26_31;
	 reg [5:0] temp_ins26_31_reg;
	 assign temp_ins26_31 = (reset) ? ins[31:26] : 6'b000000;
	 assign op_dec = temp_ins26_31_reg;   // output 1st (op_dec) upper part

    wire[15:0] temp_ins32;	 
	 reg [15:0] temp_ins32_reg;
	 assign temp_ins32 = (reset) ? ins[15:0] : 16'h0000;
	 assign imm = temp_ins32_reg;
	 

endmodule*/
