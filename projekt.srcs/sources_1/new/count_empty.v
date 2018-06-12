`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/27/2018 07:37:45 PM
// Design Name: 
// Module Name: count_empty
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


module count_empty(
    input wire [63:0] color_0_in, color_1_in,
    output reg [6:0] empty_places
    );
    reg [6:0] count_ones;
    reg [63:0] ball_reg;
    integer idx;
    
//    always @(clk) begin
//            empty_places <= 'd63 - count_ones;
//            //count_ones <= count_ones_nxt;
//        end
    
    always @* begin
        ball_reg = color_0_in | color_0_in;
        count_ones=0;
        for(idx=0; idx<=63; idx=idx+1) begin 
        count_ones = count_ones + ball_reg[idx];
        end  
        empty_places = 'd64 - count_ones;     
    end
      
    
endmodule
