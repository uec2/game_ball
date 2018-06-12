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
    
    reg [63:0] ball_reg;
    wire [6:0] empty_places;
    wire [23:0] random_number, random_empty;
    
    
    count_empty test_count_empty(
    .ball_reg(ball_reg),
    .empty_places(empty_places)
    );
    
    random random_t(
    .amount(empty_places),
    .random_number(random_number)
    );
    
    find_random_empty find_random_empty_test(
    .ball_reg(ball_reg),
    .random_number(random_number),
    .random_empty(random_empty)   
    );
    
    initial
    begin
       $display("Start of simulation");
       ball_reg = 64'h1111111111111111;
       #100 $display ("%h", random_empty);
       ball_reg = 64'hfff1111111113333;
       #100 $display ("%h", random_empty);
       ball_reg = 64'hffffffffffffff11;
       #100 $display ("%h", random_empty);
       ball_reg = 64'hffffffffffffffF1;
       #100 $display ("%h", random_empty);
       $display("Simulation is over, check the waveform");
       $stop;
    end
    
endmodule
