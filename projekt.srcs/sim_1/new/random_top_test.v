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
    
    reg [63:0] ball_reg_in;
    //wire [23:0] random_empty;
    wire [63:0] ball_reg_out;
    
    find_random_top test_find_random_top(
    .ball_reg_in(ball_reg_in),
    //.random_empty(random_empty),
    .ball_reg_out(ball_reg_out)     
    );
    
    initial
    begin
       $display("Start of simulation");
       ball_reg_in = 64'h1111111111111111;
       #100 $display ("%h", ball_reg_out);
       ball_reg_in = 64'hfff1111111113333;
       #100 $display ("%h", ball_reg_out);
       ball_reg_in = 64'hffffffffffffff11;
       #100 $display ("%h", ball_reg_out);
       ball_reg_in = 64'hfffffffffffffff1;
       #100 $display ("%h", ball_reg_out);
       $display("Simulation is over, check the waveform");
       $stop;
    end
    
endmodule
