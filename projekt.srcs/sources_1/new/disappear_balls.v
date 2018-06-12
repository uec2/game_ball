`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/31/2018 10:03:31 PM
// Design Name: 
// Module Name: disappear_balls
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


module disappear_balls(
    input wire [63:0] color_0_in,
    input wire [63:0] color_1_in,
    input wire [9:0] points_in,
    output reg [63:0] color_0_out,
    output reg [63:0] color_1_out,
    output wire [9:0] points_out,
    output wire set_new
    );
    
    integer i,n;
    reg [7:0] counter_x0, counter_y0;
    reg [7:0] counter_x1, counter_y1;
    reg [6:0] four_counter0, four_counter1;
    //reg [63:0] color_0_nxt, color_1_nxt; 
    
    always @* begin
    four_counter0=0;
    four_counter1=0;
    color_0_out = color_0_in;
    color_1_out = color_1_in;
        for(n=0; n<8; n=n+1) begin     
            counter_x0=0; 
            counter_y0=0;  
            counter_x1=0; 
            counter_y1=0;      
            for(i=0; i<8; i=i+1) begin
            // liczenie i niszczenie color_0
                if(color_0_in[(n*8)+i]) 
                counter_x0 = counter_x0 + 1;
                else counter_x0 = 0;                 
                if(color_0_in[(i*8)+n]) 
                counter_y0 = counter_y0 + 1;
                else counter_y0 = 0;   
                           
                if(counter_x0 >= 4) begin 
                    four_counter0 = four_counter0 + 1; 
                    color_0_out[(n*8)+i] = 0;
                    color_0_out[(n*8)+i-1] = 0;
                    color_0_out[(n*8)+i-2] = 0;
                    color_0_out[(n*8)+i-3] = 0;
                end  
                if(counter_y0 >=4) begin 
                    four_counter0 = four_counter0 + 1; 
                    color_0_out[(i*8)+n] = 0;
                    color_0_out[(i*8)+n-1] = 0;
                    color_0_out[(i*8)+n-2] = 0;
                    color_0_out[(i*8)+n-3] = 0;                  
                end      

                
            // liczenie i niszczenie color_1 
                if(color_1_in[(n*8)+i]) 
                counter_x1 = counter_x1 + 1;
                else counter_x1 = 0;
                if(color_1_in[(i*8)+n]) 
                counter_y1 = counter_y1 + 1;
                else counter_y1 = 0;
                
                if(counter_x1 >= 4) begin 
                    four_counter1 = four_counter1 + 1; 
                    color_1_out[(n*8)+i] = 0;
                    color_1_out[(n*8)+i-1] = 0;
                    color_1_out[(n*8)+i-2] = 0;
                    color_1_out[(n*8)+i-3] = 0;
                end  
                if(counter_y1 >=4) begin 
                    four_counter1 = four_counter1 + 1; 
                    color_1_out[(i*8)+n] = 0;
                    color_1_out[(i*8)+n-1] = 0;
                    color_1_out[(i*8)+n-2] = 0;
                    color_1_out[(i*8)+n-3] = 0;
                end                                    
            end               
        end 
    end
    
    assign points_out = points_in + four_counter0 + four_counter1;   
    assign set_new = (points_out > points_in) ? 0 : 1;
    
endmodule
