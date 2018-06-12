`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/06/2018 12:40:21 AM
// Design Name: 
// Module Name: move_top
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


module move_top(
    input clk,
    input rst,
    input wire [11:0] xpos_mouse, ypos_mouse,
    input wire mouse_left,
    input wire [63:0] color_0_in, color_1_in,
    
    output wire [63:0] color_0_out, color_1_out,
    output wire follow_ball,
    output wire back_ball,
    output wire set_ball
    );
    
    wire [3:0] column_c, row_c, column_out_r, row_out_r, column_out_d, row_out_d;
    wire [63:0] color_0_c, color_1_c, color_0_r, color_1_r, color_0_d, color_1_d;
    wire empty, putting_end, delete;
    
    
    convert_to_row_col put_convert(
    .clk(clk),
    .rst(rst),
    .xpos(xpos_mouse),
    .ypos(ypos_mouse),
    
    .column(column_c),
    .row(row_c)
    );
    
    write_data check_write_data(
    .clk(clk),
    .rst(rst),
    .check(1'b1),
    .record(1'b0),
    .xparam(row_c),
    .yparam(column_c),
    .ball_color(),
    .color_0_in(color_0_in),
    .color_1_in(color_1_in),
    
    .color_0_out(color_0_c),
    .color_1_out(color_1_c),
    .ball_reg(),
    .empty(empty)
    );
    
    putting ball_putting(
    .clk(clk),
    .rst(rst),
    .mouse_left(mouse_left),
    .empty(empty),
    .column_in(column_c),
    .row_in(row_c),
    
    .column_out_r(column_out_r),
    .row_out_r(row_out_r),
    .column_out_d(column_out_d),
    .row_out_d(row_out_d),    
    .follow_ball(follow_ball),
    .back_ball(back_ball),
    .putting_end(putting_end), 
    .delete(delete)
    );
    
    write_data delete_data(
   .clk(clk),
   .rst(rst),
   .check(1'b0),
   .delete(delete),
   .record(1'b0),
   .xparam(row_out_d),
   .yparam(column_out_d),
   .ball_color(),
   .color_0_in(color_0_r),
   .color_1_in(color_1_r),
   
   .color_0_out(color_0_d),
   .color_1_out(color_1_d),
   .ball_reg(),
   .empty()    
   );
   
   reg [3:0] row_end, col_end;
   
   always @* begin  
       if(back_ball) begin 
        row_end = row_out_d;
        col_end = column_out_d;
        end
        else if(putting_end) begin
        row_end = row_out_r;
        col_end = column_out_r;
        end  
     end
     
        
    write_data record_data(
    .clk(clk),
    .rst(rst),
    .check(1'b0),
    .delete(1'b0),
    .record(back_ball | putting_end),
    .xparam(row_end),
    .yparam(col_end),
    .ball_color(),
    .color_0_in(color_0_d),
    .color_1_in(color_1_d),
    
    .color_0_out(color_0_out),
    .color_1_out(color_1_out),
    .ball_reg(),
    .empty()    
    );
    

    
    
endmodule
