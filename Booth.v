`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:24:00 12/07/2019 
// Design Name: 
// Module Name:    Booth 
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
module Booth(X,Y,Z);

		 input signed [15:0] X, Y;
       output signed [31:0] Z;
       reg signed [31:0] Z;
       reg [1:0] temp;
       integer i;
       reg E1;
       reg [15:0] Y1;
       always @ (X, Y)
       begin
       Z = 32'b00000000000000000000000000000000;
       E1 = 1'b0;
       for (i = 0; i < 16; i = i + 1)
       begin
       temp = {X[i], E1};
       Y1 = - Y;
		 case (temp)
       2'b10 : Z [31 : 16] = Z [31 : 16] + Y1;
       2'b01 : Z [31 : 16] = Z [31 : 16] + Y;
       default : begin end
       endcase
       Z = Z >> 1;
       Z[31] = Z[30];
       E1 = X[i];
       end
       if (Y == 16'b0000000000100000)
     
     
           begin
               Z = - Z;
           end     
       end            
endmodule
