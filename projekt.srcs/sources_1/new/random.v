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


module random #(parameter WIDTH = 23, AMOUNT = 7, DIV = 6) (
 input wire clk,
 input wire rnd_col_en,
 input wire [DIV:0] divider,
 input wire repeat_num,
 output reg [WIDTH:0] random_number
    );
        
  always @* begin
  if(rnd_col_en==1) begin
     random_number[AMOUNT : 0] = 0;//$urandom%divider;
     random_number[(AMOUNT*2+1) : (AMOUNT+1)] = 1;//$urandom%divider;
     random_number[(AMOUNT*3+2) : (AMOUNT*2+2)] = 2;// $urandom%divider;
     
//     if(!repeat_num) begin
//         while(random_number[AMOUNT : 0] == random_number[(AMOUNT*2+1) : (AMOUNT+1)])
//         random_number[(AMOUNT*2+1) : (AMOUNT+1)] = 0;//$urandom%divider;
//         while(random_number[(AMOUNT*3+2) : (AMOUNT*2+2)] == random_number[(AMOUNT*2+1) : (AMOUNT+1)])
//         random_number[(AMOUNT*3+2) : (AMOUNT*2+2)] = 1;//$urandom%divider;
//         while(random_number[AMOUNT : 0] == random_number[(AMOUNT*3+2) : (AMOUNT*2+2)])
//         random_number[(AMOUNT*3+2) : (AMOUNT*2+2)] = 2;//$urandom%divider;
//     end
  end      
  end      
  //assign random_number[6:0] = $random%amount;
//  assign random_number[14:7] = $random%amount;
//  assign random_number[22:15] = $random%amount;
    
endmodule
