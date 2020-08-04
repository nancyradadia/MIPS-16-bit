`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:50:56 10/01/2019 
// Design Name: 
// Module Name:    alu 
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
/*
module right_shift(A,B,out);
	input signed [15:0]A,B;
	output [15:0]out;
	assign out = A>>>B;
	//assign out[15] = A[15];
	//assign out[14:0] = A>>B;  //shifting bits to rights by reserving the MSB

endmodule

module alu(A,B,data_in,op_dec,clk,reset,ans_ex,DM_data,data_out,flag_ex
    );
	 
	input [15:0] A,B,data_in;			
	input [5:0] op_dec;
	input clk,reset;
	output reg[15:0] ans_ex,DM_data,data_out;
	output  [1:0] flag_ex;
	
	wire [15:0] n,ans_tmp,data_out_buff,temp,temp1,temp3;
	wire c1,c2;
	wire [15:0] sum;
	wire  overflow,zero;
	wire [1:0] temp2;
	
	
	reg [1:0]flag_prv;
		
	right_shift call(A,B,temp);
	
	assign n = (op_dec[0]==1'b0) ? B :
				  (op_dec[0]==1'b1) ? ~B + 16'b0000000000000001 : B;	//taking 2's complement if subtraction is to be done
	
	assign {c1,sum[14:0]} = A[14:0]+n[14:0];					
	assign {c2,sum[15]} = A[15]+n[15]+c1;						//addition of two numbers A and B
	assign overflow = c1^c2;													//overflow 
	
	
	assign ans_tmp= (op_dec==6'b000000) ? sum : //1
						 (op_dec==6'b000001) ? sum :
						 (op_dec==6'b000010) ? B :
						 (op_dec==6'b000100) ? A&B :
						 (op_dec==6'b000101) ? A|B :
						 (op_dec==6'b000110) ? A^B :
						 (op_dec==6'b000111) ? ~B :
						 (op_dec==6'b001000) ? sum:  //8
						 (op_dec==6'b001001) ? sum :   //9
						 (op_dec==6'b001010) ? B :
						 (op_dec==6'b001100) ? A&B : 
						 (op_dec==6'b001101) ? A|B :
						 (op_dec==6'b001110) ? A^B :
						 (op_dec==6'b001111) ? ~B:
						 (op_dec==6'b010000) ? ans_ex:     //15
						 (op_dec==6'b010001) ? ans_ex:
						 (op_dec==6'b010100) ? A:
						 (op_dec==6'b010101) ? A:
						 (op_dec==6'b010110) ? data_in:
						 (op_dec==6'b010111) ? ans_ex:    //20
						 (op_dec==6'b011000) ? ans_ex:
						 (op_dec==6'b011001)	? A<<B:
						 (op_dec==6'b011010) ? A>>B:
						 (op_dec==6'b011011) ?  temp:
						 (op_dec==6'b011100) ? ans_ex:
						 (op_dec==6'b011101) ? ans_ex:
						 (op_dec==6'b011110) ? ans_ex:
						 (op_dec==6'b011111) ? ans_ex:
						 1'b0;	

   assign zero = (ans_tmp==16'b0000000000000000)?1'b1:1'b0;				//detecting zero flag
	assign data_out_buff = (op_dec == 6'b010111) ? A : data_out; 
	
	//overflow flag conditions
	assign flag_ex[0] =  (op_dec==6'b000000) ? overflow:
							   (op_dec==6'b000001) ? overflow:					
								(op_dec==6'b000010) ? 1'b0:
								(op_dec==6'b000100) ? 1'b0:
								(op_dec==6'b000101) ? 1'b0:
								(op_dec==6'b000110) ? 1'b0:
								(op_dec==6'b000111) ? 1'b0:
								(op_dec==6'b001000) ? overflow:
								(op_dec==6'b001001) ? overflow:
								(op_dec==6'b001010) ? 1'b0:
								(op_dec==6'b001100) ? 1'b0:
								(op_dec==6'b001101) ? 1'b0:
								(op_dec==6'b001110) ? 1'b0:
								(op_dec==6'b001111) ? 1'b0:
								(op_dec==6'b010000) ? 1'b0:
								(op_dec==6'b010001) ? 1'b0:
								(op_dec==6'b010100) ? 1'b0:
								(op_dec==6'b010101) ? 1'b0:
								(op_dec==6'b010110) ? 1'b0:
								(op_dec==6'b010111) ? 1'b0:
								(op_dec==6'b011000) ? 1'b0:
								(op_dec==6'b011001) ? 1'b0:
								(op_dec==6'b011010) ? 1'b0:
								(op_dec==6'b011011) ? 1'b0:
								(op_dec==6'b011100) ? 1'b0:
								(op_dec==6'b011101) ? 1'b0:
								(op_dec==6'b011110) ? 1'b0:
								(op_dec==6'b011111) ? 1'b0:
								1'b0;
								
	//assigning zero flag 1 when ans_tmp returns zero value
	assign flag_ex[1] =  (op_dec==6'b000000) ? zero:
							   (op_dec==6'b000001) ? zero:
							   (op_dec==6'b000010) ? zero:
								(op_dec==6'b000100) ? zero:
								(op_dec==6'b000101) ? zero:
								(op_dec==6'b000110) ? zero:
								(op_dec==6'b000111) ? zero:
								(op_dec==6'b001000) ? zero:
								(op_dec==6'b001001) ? zero:
								(op_dec==6'b001010) ? zero:
								(op_dec==6'b001100) ? zero:
								(op_dec==6'b001101) ? zero:
								(op_dec==6'b001110) ? zero:
								(op_dec==6'b001111) ? zero:
								(op_dec==6'b010000) ? 1'b0:
								(op_dec==6'b010001) ? 1'b0:
								(op_dec==6'b010100) ? 1'b0:
								(op_dec==6'b010101) ? 1'b0:
								(op_dec==6'b010110) ? zero:
								(op_dec==6'b010111) ? 1'b0:
								(op_dec==6'b011000) ? 1'b0:
								(op_dec==6'b011001) ? zero:
								(op_dec==6'b011010) ? zero:
								(op_dec==6'b011011) ? zero:
								(op_dec==6'b011100) ? flag_prv:
								(op_dec==6'b011101) ? flag_prv:
								(op_dec==6'b011110) ? flag_prv:
								(op_dec==6'b011111) ? flag_prv:
								1'b0;
  	 assign temp1 = (reset==1) ? (ans_tmp) : 16'b0;   // assigining outputs of the alu to the temporary wire and then storing in register
	 assign temp2 = (reset==1) ? flag_ex : 2'b0;							  
	 assign temp3 = (reset==1) ? data_out_buff : 16'b0;
	 
	

	always @(posedge clk)
	begin
		 
		 ans_ex = temp1;				
		 flag_prv = temp2;		 
		 data_out = temp3;
		 DM_data = B;

	end
	
endmodule
*/

module alu(A,B,data_in,op_dec,clk,reset,ans_ex,DM_data,data_out,flag_ex);

input [15:0] A,B,data_in;
input [5:0] op_dec;
input clk,reset;
output reg [15:0] ans_ex,DM_data,data_out;
output [1:0] flag_ex;
wire [15:0] ans_tmp,data_out_buff, return1;
reg [1:0] flag_prv;
wire zero,overflow;

wire cb;
wire [15:0] sum,subtract;
assign sum = A+B;
assign subtract = A + (~B) + 1'b1;

RSA m1 (A,B,return1);
OVERFLOW m2(A,B,op_dec,flag_prv[0],overflow);


wire signed [31:0] bo;
Booth b(A,B,bo);

wire  [15:0]quo;
wire  [15:0]rem;
Division d2(A,B,quo,rem);
assign ans_tmp =
((op_dec == 6'b000000) ? sum :
((op_dec == 6'b000001) ? subtract :
((op_dec == 6'b000010) ? B :
((op_dec == 6'b000100) ? A&B :
((op_dec == 6'b000101) ? A|B :
((op_dec == 6'b000110) ? A^B :
((op_dec == 6'b000111) ? ~B :
((op_dec == 6'b001000) ? sum:
((op_dec == 6'b001001) ? subtract:
((op_dec == 6'b001010) ? B :
((op_dec == 6'b001100) ? A&B :
((op_dec == 6'b001101) ? A|B :
((op_dec == 6'b001110) ? A^B :
((op_dec == 6'b001111) ? ~B :
((op_dec == 6'b010000) ? ans_ex:
((op_dec == 6'b010001) ? ans_ex:
((op_dec == 6'b010100) ? A :
((op_dec == 6'b010101) ? A:
((op_dec == 6'b010110) ? data_in:
((op_dec == 6'b010111) ? ans_ex:
((op_dec == 6'b011000) ? ans_ex:
((op_dec == 6'b011001) ? A<<B:
((op_dec == 6'b011010) ? A>>B:
((op_dec == 6'b011011) ? return1:
((op_dec == 6'b011100) ? ans_ex:
((op_dec == 6'b011101) ? ans_ex:
((op_dec == 6'b011110) ? ans_ex:
((op_dec == 6'b100000) ? bo[15:0]:
((op_dec == 6'b100001) ? quo:
 ans_ex )))))))))))))))))))))))))))));


assign data_out_buff = ((op_dec==6'b010111) ? A : data_out);
assign zero = (ans_tmp == 16'b0000000000000000) ? 1'b1 : 1'b0;

wire boothcheck;
assign boothcheck = (bo[16]==1) ? 1 : 0;

assign flag_ex =
((op_dec == 6'b000000) ? {zero,overflow} :
((op_dec == 6'b000001) ? {zero,overflow} :
((op_dec == 6'b000010) ? {zero,1'b0} :
((op_dec == 6'b000100) ? {zero,1'b0} :
((op_dec == 6'b000101) ? {zero,1'b0} :
((op_dec == 6'b000110) ? {zero,1'b0} :
((op_dec == 6'b000111) ? {zero,1'b0} :
((op_dec == 6'b001000) ? {zero,overflow} :
((op_dec == 6'b001001) ? {zero,overflow} :
((op_dec == 6'b001010) ? {zero,1'b0} :
((op_dec == 6'b001100) ? {zero,1'b0} :
((op_dec == 6'b001101) ? {zero,1'b0} :
((op_dec == 6'b001110) ? {zero,1'b0} :
((op_dec == 6'b001111) ? {zero,1'b0} :
((op_dec == 6'b010000) ? 2'b00:
((op_dec == 6'b010001) ? 2'b00:
((op_dec == 6'b010100) ? 2'b00:
((op_dec == 6'b010101) ? 2'b00:
((op_dec == 6'b010110) ? {zero,1'b0} :
((op_dec == 6'b010111) ? 2'b00:
((op_dec == 6'b011000) ? 2'b00:
((op_dec == 6'b011001) ? {zero,1'b0} :
((op_dec == 6'b011010) ? {zero,1'b0} :
((op_dec == 6'b011011) ? {zero,1'b0} :
((op_dec == 6'b011100) ? flag_prv :
((op_dec == 6'b011101) ? flag_prv :
((op_dec == 6'b011110) ? flag_prv :
((op_dec == 6'b100000) ? {zero,boothcheck} :
 flag_prv ))))))))))))))))))))))))))));

always@(posedge clk or negedge reset) begin
ans_ex <= (!reset) ? 16'b0000000000000000 : ans_tmp;
data_out <= (!reset) ? 16'b0000000000000000 : data_out_buff;
flag_prv <= (!reset) ? 2'b00 : flag_ex;
DM_data <= (!reset) ? 16'b0000000000000000 : B;
end

endmodule

module RSA (A,B,C);
input signed [15:0] A,B;
output [15:0] C;
assign C = A>>>B;
endmodule

module OVERFLOW(A,B,op_dec,flag,overflow);

input [15:0] A,B;
input [5:0] op_dec;
input flag;
output overflow;

wire [15:0] sd1,sd3;
wire [1:0] sd2,sd4;
wire [15:0] C;
assign sd1 = A[14:0] + B[14:0];
assign sd2 = A[15] + B[15] + sd1[15];
assign C = ~B + 1'b1;
assign sd3 = A[14:0] + C[14:0];
assign sd4 = A[15] + C[15] + sd3[15];

assign overflow = (op_dec==6'b000000 || op_dec==6'b001000) ? (sd2[1]^sd1[15])
: ((op_dec==6'b000001 || op_dec==6'b001001) ? (sd4[1]^sd3[15]) :  flag);

endmodule


