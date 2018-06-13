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
    input wire clk,
    input wire reset,
    input wire find_en,
    input wire [8:0] random_colors_in,
    input wire [63:0] color_0_in, color_1_in,
    input wire [2:0] color_amount,
    output reg [23:0] random_empty,
    output reg [63:0] color_0_out, color_1_out,
    output reg [8:0] random_colors_out,
    output reg end_game,
    output reg find_end
    );
    
    wire [6:0] empty_places;
    wire [23:0] random_number;
    
    //reg [63:0] ball_reg_temp;
    wire [23:0] random_empty_nxt;
    wire [63:0] color_0_nxt, color_1_nxt;
    wire [8:0] random_colors_nxt;
    wire [12:0] random_lfsr;
    
    always @(posedge clk) begin
        if(find_en) begin
        random_empty = random_empty_nxt;
        color_0_out = color_0_nxt;
        color_1_out = color_1_nxt;
        random_colors_out = random_colors_nxt; 
        if(empty_places<3) end_game = 1;
        else end_game = 0;
        if((color_0_out!=color_0_in) | (color_1_out!=color_1_in)) find_end = 1;
        else find_end = 0;
        end
    end
    
    count_empty my_count_empty(
    .clk(clk),
    .color_0_in(color_0_in),
    .color_1_in(color_1_in),
    .empty_places(empty_places)
    );
    
    LFSR random_LFSR(
    .clock(clk),
    .reset(reset),
    .rnd(random_lfsr) 
    );
    
    random #(.WIDTH(23), .AMOUNT(7), .DIV(6)) random_places(
    .clk(clk),
    .reset(reset),
    .rnd_col_en(1'b1),
    .divider(empty_places),
    .repeat_num(1'b0),
    .random_number(random_number),
    .random_lfsr(random_lfsr)
    );
    
    random #(.WIDTH(8), .AMOUNT(2), .DIV(2)) random_color(
    .clk(clk),
    .reset(clk),
    .rnd_col_en(1'b1),
    .divider(color_amount),
    .repeat_num(1'b1),
    .random_number(random_colors_nxt),
    .random_lfsr(random_lfsr)
    );
    
    find_random_empty find_empty(
    .clk(clk),
    .color_0_in(color_0_in),
    .color_1_in(color_1_in),
    .random_number(random_number),
    .random_empty(random_empty_nxt),
    .random_color(random_colors_in),
    .color_0_out(color_0_nxt),
    .color_1_out(color_1_nxt)
    );
//    always @* begin
//          ball_reg_temp = (ball_reg_in << random_empty[0:7]);
//        //ball_reg_out = ball_reg_temp | 63'h0000000000000001;
////        ball_reg_out = (((ball_reg_in >> random_empty[0:7]) | 8'b00000001) |
////        ((ball_reg_in >> random_empty[15:8]) | 8'b00000001) | 
////        ((ball_reg_in >> random_empty[23:16]) | 8'b00000001));    
//    end
    


endmodule
