`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/27/2018 11:11:00 PM
// Design Name: 
// Module Name: random_test
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


module random_test();
    
    reg [63:0] color_0_in, color_1_in;
    wire [6:0] empty_places;
    wire [20:0] random_number;
    wire [8:0] random_num_color;
    reg [2:0] color_amount;
    
    
    count_empty my_count_empty(
    .color_0_in(color_0_in),
    .color_1_in(color_1_in),
    .empty_places(empty_places)
    );
    
    random #(.WIDTH(20), .AMOUNT(6)) random_places(
    .amount(empty_places),
    .repeat_num(1'b0),
    .random_number(random_number)
    );
    
    random #(.WIDTH(8), .AMOUNT(2)) random_color(
    .amount(color_amount),
    .repeat_num(1'b1),
    .random_number(random_num_color)
    );
    
    initial
    begin
       $display("Start of simulation");
       color_amount = 4'b0010;
       color_0_in = 64'h1111111111111111; 
       color_1_in = 64'h2222222222222222;
       #100 $display ("%h", empty_places);
       color_amount = 4'b0010;
       color_0_in = 64'h0333333333333333;
       color_1_in = 64'hccccccccccccccc0;
       #100 $display ("%h", empty_places);
       $display("Simulation is over, check the waveform");
       $stop;
    end
    
endmodule
