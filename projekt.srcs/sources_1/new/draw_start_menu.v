`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/25/2018 07:39:03 PM
// Design Name: 
// Module Name: draw_start_menu
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


module draw_start_menu(
  input wire [10:0] vcount_in,
  input wire vsync_in,
  input wire vblnk_in,
  input wire [10:0] hcount_in,
  input wire hsync_in,
  input wire hblnk_in,
  input wire pclk,
  input wire rst,  
  input wire [11:0] xpos_m,
  input wire [11:0] ypos_m,
  input wire left_mouse,
  
  output reg [10:0] vcount_out,
  output reg vsync_out,
  output reg vblnk_out,
  output reg [10:0] hcount_out,
  output reg hsync_out,
  output reg hblnk_out,
  output reg [11:0] rgb_out,
  output reg run_out
    );
    
    localparam  START_BTN_COLOR = 12'hf_0_0,
                START_LIGHT_COLOR = 12'hf_1_0,
                BACK_COLOR = 12'h0_0_0,
                ARROW_COLOR = 12'ha_0_0;
    
  reg [11:0] rgb_out_nxt;
  reg run_nxt, pushed=0;
  
         
    always @(posedge pclk)
      begin
          if(rst)
              begin
                  vcount_out <= 0;
                  hcount_out <= 0;
                  
                  vsync_out <= 0;
                  vblnk_out <= 0;
                  hsync_out <= 0;
                  hblnk_out <= 0;
                  
                  rgb_out <= 0;
                  run_out <= 0;
              end
          else
              begin
                  vcount_out <= vcount_in;
                  hcount_out <= hcount_in;
                  
                  vsync_out <= vsync_in;
                  vblnk_out <= vblnk_in;                
                  hsync_out <= hsync_in;
                  hblnk_out <= hblnk_in;
                  
                  rgb_out <= rgb_out_nxt;
                  run_out <= run_nxt;
              end
      end
      
  always @*
    begin
        if(xpos_m >= 250 && xpos_m <= 550 && xpos_m >= 400 && xpos_m <= 500) 
        begin
            pushed = !left_mouse;            
            if(hcount_in >= 250 && hcount_in <= 550 && vcount_in >= 400 && vcount_in <= 500)rgb_out_nxt = START_LIGHT_COLOR;
            else rgb_out_nxt = rgb_out;
        end
        
        if(pushed == 1 && left_mouse == 0) run_nxt = 1;
        else run_out = 0;
        
        if (vblnk_in || hblnk_in) rgb_out_nxt = BACK_COLOR; 
        else
        begin
        if(hcount_in >= 250 && hcount_in <= 550 && vcount_in >= 400 && vcount_in <= 500) rgb_out_nxt = START_BTN_COLOR; 
        else if(hcount_in >= 425 && hcount_in <= 575 && vcount_in >= 400 && vcount_in <= 500) rgb_out_nxt = ARROW_COLOR;
        else rgb_out_nxt <= BACK_COLOR;          
       end
   
    end   
endmodule
