`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/12/2018 11:21:10 PM
// Design Name: 
// Module Name: control_ms
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


module control_ms(
    input wire clk,
    input wire reset,
    input wire go,
    
    input wire [63:0] color_0_find, color_0_mv, color_0_dsp,
    input wire [63:0] color_1_find, color_1_mv, color_1_dsp,
    input wire set_ball,
    input wire [9:0] points_in,
    input wire find_end,
    
    output reg [63:0] color_0_out,
    output reg [63:0] color_1_out,
    
    output reg rnd_col_en, find_en, move_en, disp_en,
    output reg [23:0] random_empty,
    output reg [9:0] points_out

    );
    
localparam  IDLE = 4'b0000,
            START = 4'b0001,
            RANDOM = 4'b0010,
            MOVE = 4'b0011,
            DISAPPEAR = 4'b0100,
            END = 4'b0101,
            RANDOM_NXT = 4'b0110,
            MOVE_NXT = 4'b0111,
            DISP_NXT = 4'b1000;

    
    reg [2:0] state_nxt, state;
    reg  set_new;
    reg [63:0] color_0_nxt, color_1_nxt;
    
    reg [8:0] random_colors_in, random_colors_out, random_colors_nxt;
                
    always @(posedge clk) begin
        if(reset)begin
        state <= 0;
        end
        
        else begin
        state <= state_nxt;
        color_0_out <= color_0_nxt;
        color_1_out <= color_1_nxt;
        random_colors_in <= random_colors_nxt;
        points_out <= points_in;
        end
    
    end
    
    
    always @* begin
        case(state)
            IDLE: state_nxt = go ? START : IDLE;
            START: state_nxt = RANDOM;
            RANDOM: state_nxt = find_end ? RANDOM_NXT : RANDOM; 
            RANDOM_NXT: state_nxt = MOVE;
            
            MOVE: state_nxt = set_ball ? MOVE_NXT : MOVE;
            MOVE_NXT: state_nxt = DISAPPEAR;
            
            DISAPPEAR: state_nxt = set_new ? DISP_NXT : RANDOM;
            DISP_NXT: state_nxt = MOVE;
            default: state_nxt = IDLE;
        endcase
    end
    
              
    always @* begin
        case(state)
            IDLE: begin
                //set_ball = 1'b0;
                //set_new = 1'b0;
                color_0_nxt = 64'h0;
                color_1_nxt = 64'h0;       
            end
            START: begin
                random_empty = 64;
                rnd_col_en = 1'b1;
            end
            RANDOM: begin
                rnd_col_en = 1'b0;
                find_en = 1'b1;
            end
            RANDOM_NXT: begin
                color_0_nxt = color_0_find;
                color_1_nxt = color_1_find;            
            end
            MOVE: begin
                find_en = 1'b0;
                move_en = 1'b1;
            end
            MOVE_NXT: begin
                color_0_nxt = color_0_mv;
                color_1_nxt = color_1_mv;           
            end
            DISAPPEAR: begin
                move_en = 1'b0;
                disp_en = 1'b1;
            end
            DISP_NXT: begin
                color_0_nxt = color_0_dsp;
                color_1_nxt = color_1_dsp;       
            end
            //default: state_nxt = IDLE;
        endcase
    end          
              
                      
    
    endmodule
   
