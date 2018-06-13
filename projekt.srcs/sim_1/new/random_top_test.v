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
    wire [8:0] random_num_color,random_colors_in;
    reg clk, reset;
    wire end_game, find_end;
    wire [12:0] random_lfsr;
    
        always
    begin
        clk =1'b0;
        #10;
        clk = 1'b1;
        #10;
    end
    
            
    LFSR random_LFSR1(
    .clock(clk),
    .reset(reset),
    .rnd(random_lfsr) 
    ); 
    
    
    random #(.WIDTH(8), .AMOUNT(2), .DIV(2)) random_color(
    .clk(clk),
    .reset(reset),
    .rnd_col_en(1'b1),
    .divider(color_amount),
    .repeat_num(1'b1),
    .random_number(random_colors_in),
    .random_lfsr(random_lfsr)
    );
    
    
    
    find_random_top find_core(
    .clk(clk),
    .reset(reset),
    .find_en(1'b1),
    .color_0_in(color_0_in),
    .color_1_in(color_1_in),
    .random_colors_in(random_colors_in),
    .color_amount(color_amount),
    .random_empty(random_empty),
    .color_0_out(color_0_out), 
    .color_1_out(color_1_out),
    .random_colors_out(random_num_color),
    .end_game(end_game),
    .find_end(find_end)
    );
    
    initial
    begin
       $display("Start of simulation");
       reset = 1'b1;
       #20 reset = 1'b0;
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
