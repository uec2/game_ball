`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/27/2018 07:20:08 PM
// Design Name: 
// Module Name: random
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module random #(parameter WIDTH = 23, AMOUNT = 6) (
// input wire clk,
 input wire [AMOUNT:0] amount,
 input wire repeat_num,
 output reg [WIDTH:0] random_number
    );
        
  always @* begin
     random_number[AMOUNT : 0] = $urandom%amount;
     random_number[(AMOUNT*2+1) : (AMOUNT+1)] = $urandom%amount;
     random_number[(AMOUNT*3+2) : (AMOUNT*2+2)] = $urandom%amount;
     
     if(!repeat_num) begin
         while(random_number[AMOUNT : 0] == random_number[(AMOUNT*2+1) : (AMOUNT+1)])
         random_number[(AMOUNT*2+1) : (AMOUNT+1)] = $urandom%amount;
         while(random_number[(AMOUNT*3+2) : (AMOUNT*2+2)] == random_number[(AMOUNT*2+1) : (AMOUNT+1)])
         random_number[(AMOUNT*3+2) : (AMOUNT*2+2)] = $urandom%amount;
         while(random_number[AMOUNT : 0] == random_number[(AMOUNT*3+2) : (AMOUNT*2+2)])
         random_number[(AMOUNT*3+2) : (AMOUNT*2+2)] = $urandom%amount;
     end
  end      
        
  //assign random_number[6:0] = $random%amount;
//  assign random_number[14:7] = $random%amount;
//  assign random_number[22:15] = $random%amount;
    
endmodule
