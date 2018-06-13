`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/13/2018 12:59:24 AM
// Design Name: 
// Module Name: core_modules
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


module core_modules(
    input wire clk,
    input wire reset,
    input wire go,
    input wire [2:0] color_amount,
    input wire [63:0] color_0_in,
    input wire [63:0] color_1_in,
    input wire [11:0] xpos_mouse, ypos_mouse,
    input wire mouse_left,
    input wire [9:0] points_in,
    
    input wire rnd_col_en, find_en, move_en, disp_en,
    
    output reg [63:0] color_0_out,
    output reg [63:0] color_1_out,
    
    output wire [63:0] color_0_find, color_0_mv, color_0_dsp,
    output wire [63:0] color_1_find, color_1_mv, color_1_dsp,
    output reg [8:0] random_colors_out,
    output wire follow_ball, back_ball, set_ball, set_new,
    output wire [9:0] points_out,
    output wire [23:0] random_empty
);

            
            
reg [2:0] state_nxt, state;
reg [63:0] color_0_nxt, color_1_nxt;

wire [8:0] random_colors_in, random_colors_nxt;
//reg rnd_col_en, find_en;
            
always @(posedge clk) begin
    if(reset)begin
    random_colors_out <= 0;
    end  
    else begin
    random_colors_out <= random_colors_nxt;
    end

end


    random #(.WIDTH(8), .AMOUNT(2), .DIV(2)) random_color(
    .clk(clk),
    .rnd_col_en(rnd_col_en),
    .divider(color_amount),
    .repeat_num(1'b1),
    .random_number(random_colors_in)
    );


    find_random_top find_core(
    .clk(clk),
    .find_en(find_en),
    .color_0_in(color_0_in),
    .color_1_in(color_1_in),
    .random_colors_in(random_colors_in),
    .color_amount(color_amount),
    .random_empty(random_empty),
    .color_0_out(color_0_find), 
    .color_1_out(color_1_find),
    .random_colors_out(random_colors_nxt)
    );
    
    move_top move_core(
    .clk(clk),
    .rst(reset),
    .move_en(move_en),
    .xpos_mouse(xpos_mouse), 
    .ypos_mouse(ypos_mouse),
    .mouse_left(mouse_left),
    .color_0_in(color_0_in), 
    .color_1_in(color_0_in),
    
    .color_0_out(color_0_mv), 
    .color_1_out(color_1_mv),
    .follow_ball(follow_ball),
    .back_ball(back_ball),
    .set_ball(set_ball)
    );
                    
    disappear_balls disppear_core(
    .clk(clk),
    .disp_en(disp_en),
    .color_0_in(color_0_in),
    .color_1_in(color_1_in),
    .points_in(points_in),
    .color_0_out(color_0_dsp),
    .color_1_out(color_1_dsp),
    .points_out(points_out),
    .set_new(set_new)  
    );       
                  

endmodule
