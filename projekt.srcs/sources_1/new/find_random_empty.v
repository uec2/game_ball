`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/27/2018 08:37:52 PM
// Design Name: 
// Module Name: find_random_empty
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


module find_random_empty(
    input wire [63:0] color_0_in, color_1_in,
    input wire [23:0] random_number,
    input wire [8:0] random_color,
    output reg [23:0] random_empty,
    output reg [63:0] color_0_out, color_1_out
    );
    
    integer idx;
    reg [1:0] n;
    reg [7:0] counter;
    reg [63:0] ball_reg_temp_1, ball_reg_temp_2, ball_reg_temp_3, ball_reg_in;
    reg [63:0] clr0_temp1, clr0_temp2, clr0_temp3, clr1_temp1, clr1_temp2, clr1_temp3;
    
    always @* begin
    counter = -1;
    random_empty = 0;
    n=0;
    ball_reg_in = color_0_in | color_1_in;
    for(idx=0; idx<=63; idx=idx+1) begin 
         if(!ball_reg_in[idx])begin
            counter = counter +1;
            if((counter == random_number[7:0]) | (counter == random_number[15:8]) | (counter == random_number[23:16])) begin
            n = n+1;
            case(n)
            1: random_empty[7:0]=idx;
            2: random_empty[15:8]=idx;
            3: random_empty[23:16]=idx;
            endcase
            end
         end
     end    
     
     ball_reg_temp_1 = 1'b1 << random_empty[7:0];
     ball_reg_temp_2 = 1'b1 << random_empty[15:8];
     ball_reg_temp_3 = 1'b1 << random_empty[23:16];      
     
     
     case(random_color[2:0]) 
     1'b0: begin 
            clr0_temp1 = ball_reg_temp_1;
            clr1_temp1 = 63'b0;
            end
     1'b1: begin
            clr1_temp1 = ball_reg_temp_1;  
            clr0_temp1 = 63'b0;
            end 
     endcase
     
     case(random_color[5:3]) 
     1'b0: begin 
            clr0_temp2 = ball_reg_temp_2;
            clr1_temp2 = 63'b0;
            end
     1'b1: begin
            clr1_temp2 = ball_reg_temp_2;  
            clr0_temp2 = 63'b0;
            end    
     endcase
     case(random_color[8:6]) 
     1'b0: begin 
            clr0_temp3 = ball_reg_temp_3;
            clr1_temp3 = 63'b0;
            end
     1'b1: begin
            clr1_temp3 = ball_reg_temp_3;  
            clr0_temp3 = 63'b0;
            end   
     endcase
          
     color_0_out = color_0_in | clr0_temp1 | clr0_temp2 | clr0_temp3;
     color_1_out = color_1_in | clr1_temp1 | clr1_temp2 | clr1_temp3;
     //ball_reg_out = ball_reg_in | ball_reg_temp_1 | ball_reg_temp_2 | ball_reg_temp_3;
    
    end
    
endmodule
