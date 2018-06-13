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
 input wire reset,
 input wire rnd_col_en,
 input wire [DIV:0] divider,
 input wire repeat_num,
 input wire [12:0] random_lfsr,
 output reg [WIDTH:0] random_number
    );
        
  reg [12:0] rnd1=0, rnd2=0, rnd3=0, rnd4=0, rnd5=0, rnd6=0;    
  reg enable; 
//  wire [12:0] random_lfsr;
        
//  LFSR random_LFSR(
//    .clock(clk),
//    .reset(reset),
//    .rnd(random_lfsr) 
//    );      
    
  always @(posedge clk) begin
  rnd1 <= random_lfsr;
  rnd2 <= rnd1;
  rnd3 <= rnd2;
  
  if(!rnd3) enable=1;
  end  
       
        
  always @* begin
  if(rnd_col_en | enable) begin
     random_number[AMOUNT : 0] = rnd1 % divider;
     random_number[(AMOUNT*2+1) : (AMOUNT+1)] = rnd2 % divider;
     random_number[(AMOUNT*3+2) : (AMOUNT*2+2)] = rnd3 % divider;
     
//     if(!repeat_num) begin
//         while(random_number[AMOUNT : 0] == random_number[(AMOUNT*2+1) : (AMOUNT+1)])
//         random_number[(AMOUNT*2+1) : (AMOUNT+1)] = random_lfsr % divider;
//         while(random_number[(AMOUNT*3+2) : (AMOUNT*2+2)] == random_number[(AMOUNT*2+1) : (AMOUNT+1)])
//         random_number[(AMOUNT*3+2) : (AMOUNT*2+2)] = random_lfsr % divider;
//         while(random_number[AMOUNT : 0] == random_number[(AMOUNT*3+2) : (AMOUNT*2+2)])
//         random_number[(AMOUNT*3+2) : (AMOUNT*2+2)] = random_lfsr % divider;
//     end
  end      
  end      
    
endmodule
