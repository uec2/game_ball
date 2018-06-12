`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/31/2018 08:02:08 PM
// Design Name: 
// Module Name: find_random_top
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


module find_random_top(
    //input wire clk,
    input wire [63:0] color_0_in, color_1_in,
    input wire color_amount,
    output wire [23:0] random_empty,
    output wire [63:0] color_0_out, color_1_out
    );
    
    wire [6:0] empty_places;
    wire [23:0] random_number;
    wire [8:0] random_num_color;
    //reg [63:0] ball_reg_temp;

    count_empty my_count_empty(
    .color_0_in(color_0_in),
    .color_1_in(color_1_in),
    .empty_places(empty_places)
    );
    
    random #(.WIDTH(23), .AMOUNT(6)) random_places(
    .amount(empty_places),
    .repeat_num(1'b0),
    .random_number(random_number)
    );
    
    random #(.WIDTH(8), .AMOUNT(2)) random_color(
    .amount(color_amount),
    .repeat_num(1'b1),
    .random_number(random_num_color)
    );
    
    find_random_empty find_empty(
    .color_0_in(color_0_in),
    .color_1_in(color_1_in),
    .random_number(random_number),
    .random_empty(random_empty),
    .random_color(random_num_color),
    .color_0_out(color_0_out),
    .color_1_out(color_1_out)
    );
    
//    always @* begin
//          ball_reg_temp = (ball_reg_in << random_empty[0:7]);
//        //ball_reg_out = ball_reg_temp | 63'h0000000000000001;
////        ball_reg_out = (((ball_reg_in >> random_empty[0:7]) | 8'b00000001) |
////        ((ball_reg_in >> random_empty[15:8]) | 8'b00000001) | 
////        ((ball_reg_in >> random_empty[23:16]) | 8'b00000001));    
//    end
    


endmodule
