`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/05/2018 11:32:59 PM
// Design Name: 
// Module Name: convert_to_row_col
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


module convert_to_row_col(
	input wire clk, rst,
    input  wire [11:0] xpos, ypos,

    output reg [3:0] column, row
    );

localparam      UP = 32,
                LEFT = 256,
                SQUARE_SIZE = 64;

reg [6:0] column_nxt, row_nxt, col_nxt, r_nxt;
reg [11:0] xpos_nxt, ypos_nxt;


always @(posedge clk)
    begin
        if(rst) begin
            column <= 0;
            row <= 0;
        end
        else begin
            column <= column_nxt;
            row <= row_nxt;
        end
    end

always @*
    begin
        xpos_nxt = xpos - LEFT;
        ypos_nxt = ypos - UP;
        col_nxt = xpos_nxt[9 : 6] + 1;
        r_nxt = ypos_nxt[9:6] + 1;
    end
endmodule
