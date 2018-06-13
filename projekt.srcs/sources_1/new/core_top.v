`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/12/2018 09:31:58 PM
// Design Name: 
// Module Name: core_top
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


module core_top(
    input wire clk,
    input wire reset,
    input wire go,
    input wire [2:0] color_amount,  
    input wire [11:0] xpos_mouse, ypos_mouse,
    input wire mouse_left,
    
    output wire [63:0] color_0_out,
    output wire [63:0] color_1_out,
    output wire [8:0] random_colors_out,
    output wire follow_ball, back_ball, set_ball,
    output wire points_out_digit    
);

wire [63:0] color_0_in, color_1_in;
wire [9:0] points_in, points_out;
wire rnd_col_en, find_en, move_en, disp_en;
wire [63:0] color_0_find, color_0_mv, color_0_dsp;
wire [63:0] color_1_find, color_1_mv, color_1_dsp;
wire set_new;
wire [23:0] random_empty;


core_modules modules(
    .clk(clk),
    .reset(reset),
    .go(go),
    .color_amount(color_amount),
    .color_0_in(color_0_in),
    .color_1_in(color_1_in),
    .xpos_mouse(xpos_mouse), 
    .ypos_mouse(ypos_mouse),
    .mouse_left(mouse_left),
    .points_in(points_in),
    .rnd_col_en(rnd_col_en), 
    .find_en(find_en), 
    .move_en(move_en), 
    .disp_en(disp_en),
    
    .color_0_out(color_0_out),
    .color_1_out(color_1_out),
    .color_0_find(color_0_find), 
    .color_0_mv(color_0_mv), 
    .color_0_dsp(color_0_dsp),
    .color_1_find(color_1_find), 
    .color_1_mv(color_1_mv), 
    .color_1_dsp(color_1_dsp),
    .random_colors_out(random_colors_out),
    .follow_ball(follow_ball), 
    .back_ball(back_ball), 
    .set_ball(set_ball), 
    .set_new(set_new),
    .points_out(points_out),
    .random_empty(random_empty)
);

control_ms machine_states(
    .clk(clk),
    .reset(reset),
    .go(go),

    .color_0_find(color_0_find), 
    .color_0_mv(color_0_mv), 
    .color_0_dsp(color_0_dsp),
    .color_1_find(color_1_find), 
    .color_1_mv(color_1_mv), 
    .color_1_dsp(color_1_dsp),
    .set_ball(set_ball),
    .points_in(points_out),
    .color_0_out(color_0_in),
    .color_1_out(color_1_in),
    
    .rnd_col_en(rnd_col_en), 
    .find_en(find_en), 
    .move_en(move_en),
    .disp_en(disp_en),
    .random_empty(random_empty),
    .points_out(points_in)
);

num_to_dig num_to_dig_c(
    .number(points_out),
    .digits(points_out_digit)
);
            
            

endmodule
