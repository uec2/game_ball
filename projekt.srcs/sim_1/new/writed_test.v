`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/26/2018 09:26:35 PM
// Design Name: 
// Module Name: writed_test
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


module writed_test(

    );
    
reg clk, rst;
reg [3:0] xpos, ypos;
reg [1:0] color;
wire [64:0] color_1, color_2;
wire [64:0] color_1_test, color_2_test;

    always
    begin
        clk =1'b0;
        #10;
        clk = 1'b1;
        #10;
    end
    
initial begin
    rst=1;
    #40;
    rst=0;
    #40;
    xpos=0;
    ypos=0;
    color=1'b0;
    #40;
    xpos=2;
    ypos=6;
    color=1'b0;
    #40;
    xpos=3;
    ypos=6;
    color=1'b1;
    #40;
   $stop;
end

assign color_1_test = 64'h00000401;
assign color_2_test = 64'h004000000;
    
    
    write_data writedata_test(
    .clk(clk),
    .rst(rst),
    .ball_color(color),
    .xparam(xpos),
    .yparam(ypos),
    .color_0(color_1),
    .color_1(color_2)
    );
    
    initial
            begin
                $display("Start of simulation");
                if(color_1 == color_1_test) $display("Test 1. pasted");
                else $display("Test 1. failed");
                if(color_2 == color_2_test) $display("Test 2. pasted");
                else $display("Test 2. failed");
                $display("Simulation is over, check the waveform");
                $stop;
            end
    
    
endmodule
