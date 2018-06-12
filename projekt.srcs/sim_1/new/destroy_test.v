`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/01/2018 12:38:16 AM
// Design Name: 
// Module Name: destroy_test
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


module destroy_test();

    reg [63:0] color_0_in, color_1_in; 
    wire [63:0] color_0_out, color_1_out;
    reg [9:0] points_in; 
    wire [9:0] points_out;
    
    disappear_balls test_disappear_balls(
    .color_0_in(color_0_in),
    .color_1_in(color_1_in),
    .points_in(points_in),
    .color_0_out(color_0_out),
    .color_1_out(color_1_out),
    .points_out(points_out)    
    );
    
    initial
    begin
       $display("Start of simulation");
//       color_0_in = 64'h1111111111111111;
//       color_1_in = 64'h2222222222222222;
//       #100 $display ("%h, %h", color_0_out, color_1_out);
       color_0_in = 64'hff0000af20242001;
       color_1_in = 64'h0000000000000000;
       points_in = 0;
       #100 $display ("%h, %h", color_0_out, color_1_out);
       $display("Simulation is over, check the waveform");
       $stop;
    end

endmodule
