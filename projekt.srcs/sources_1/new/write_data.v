`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/25/2018 08:44:51 PM
// Design Name: 
// Module Name: write_data
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


module write_data(
    input wire [3:0] xparam,
    input wire [3:0] yparam,
    input wire [1:0] ball_color,
    input wire [63:0] color_0_in, color_1_in,
    input wire record,
    input wire check,
    input wire delete,
    input wire clk,
    input wire rst,
    
    output reg [63:0] color_0_out,
    output reg [63:0] color_1_out,
    output wire [63:0] ball_reg,
    output wire empty
    );
    
    //reg [64:0] color_0, color_1; 
    reg [64:0] temp_reg, temp_reg_nxt, color_0_nxt, color_1_nxt;
   
   always @(clk)begin
    if(rst)begin
        temp_reg <= 64'b0;
        color_0_out <= 64'b0;
        color_1_out <= 64'b0;   
        color_0_nxt <= 64'b0;
        color_1_nxt <= 64'b0;
    end
    else begin
       temp_reg <= temp_reg_nxt;
       color_0_out <= color_0_nxt;
       color_1_out <= color_1_nxt;
    end
   end
   
   always @*
   begin
   
        if(check) begin
            temp_reg_nxt = 1'b1 << (xparam + 8*yparam);
            color_0_nxt = color_0_in;
            color_1_nxt = color_1_in;
        end    
            
        else begin         
            if(record) begin 
            temp_reg_nxt = 1 << (xparam + 8*yparam);   
                case(ball_color)
                1'b0: color_0_nxt = (color_0_in | temp_reg_nxt);
                1'b1: color_1_nxt = (color_1_in | temp_reg_nxt);
                endcase
            end
            else if(delete) begin 
            temp_reg_nxt = 0 << (xparam + 8*yparam);   
               case(ball_color)
               1'b0: color_0_nxt = (color_0_in & temp_reg_nxt);
               1'b1: color_1_nxt = (color_1_in & temp_reg_nxt);
               endcase
            end
            else begin
            color_0_nxt = color_0_in;
            color_1_nxt = color_1_in;
            end
        end
    end    
    
    assign ball_reg = color_0_out || color_1_out;
    assign empty = !(((temp_reg && ball_reg) >> (xparam + 8*yparam)) && 1'b1);   
    
endmodule
