`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/12/2018 06:07:58 PM
// Design Name: 
// Module Name: numtodigit_test
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


module numtodigit_test();

reg [9:0] number;
wire [11:0] digits;

num_to_dig num_to_dig_test(
.number(number),
.digits(digits)
);

    initial
    begin
       $display("Start of simulation");
       number = 123;
       #100 $display ("%d %d %d = 123", digits[11:8], digits[7:4], digits[3:0]);
       number = 999;
       #100 $display ("%d %d %d = 999", digits[11:8], digits[7:4], digits[3:0]);
       number = 100;
       #100 $display ("%d %d %d = 100", digits[11:8], digits[7:4], digits[3:0]);
       number = 192;
       #100 $display ("%d %d %d = 192", digits[11:8], digits[7:4], digits[3:0]);
       number = 32;
       #100 $display ("%d %d %d = 032", digits[11:8], digits[7:4], digits[3:0]);
       $display("Simulation is over, check the waveform");
       $stop;
    end

endmodule
