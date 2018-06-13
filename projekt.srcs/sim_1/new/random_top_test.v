`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/31/2018 08:16:50 PM
// Design Name: 
// Module Name: random_top_test
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


module random_top_test(
    );
    
    reg [63:0] color_0_in, color_1_in;
    wire [63:0] color_0_out, color_1_out;
    reg [2:0] color_amount;
    wire [23:0] random_empty;
    wire [8:0] random_num_color;
    reg clk;
    
        always
    begin
        clk =1'b0;
        #10;
        clk = 1'b1;
        #10;
    end
    
    
    find_random_top test_find_random_top(
    .clk(clk),
    .color_0_in(color_0_in), 
    .color_1_in(color_1_in),
    .color_amount(color_amount),
    .random_empty(random_empty),
    .color_0_out(color_0_out), 
    .color_1_out(color_1_out),
    .random_num_color(random_num_color)
    );
    
    initial
    begin
       $display("Start of simulation");
        color_amount = 4'b0010;
        color_0_in = 64'h1111111111111111; 
        color_1_in = 64'h2222222222222222;
        #200 $display ("color0: %h, color1: %h ", color_0_out, color_1_out);
        color_0_in = 64'h0333333333333333;
        color_1_in = 64'hccccccccccccccc0;
        #200 $display ("color0: %h, color1: %h ", color_0_out, color_1_out);
        $display("Simulation is over, check the waveform");
        $stop;
    end
    
endmodule
