`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/13/2018 03:32:53 PM
// Design Name: 
// Module Name: LFSR
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


module LFSR (
    input clock,
    input reset,
    output [12:0] rnd 
    );
 
 
reg [12:0] random, random_next, random_done;
reg [3:0] count, count_next; //to keep track of the shifts

wire feedback = random[7] ^ random[3] ^ random[2] ^ random[0]; 
 
always @ (posedge clock or posedge reset)
begin
 if (reset)
 begin
  random <= 13'hF; //An LFSR cannot have an all 0 state, thus reset to FF
  count <= 0;
 end
  
 else
 begin
  random <= random_next;
  count <= count_next;
 end
end
 
always @ (*)
begin
 random_next = random; //default state stays the same
 count_next = count;
   
  random_next = {random[6:0], feedback}; //shift left the xor'd every posedge clock
  count_next = count + 1;
 
 if (count == 8)
 begin
  count = 0;
  random_done = random; //assign the random number to output after 13 shifts
 end
  
end
 
 
assign rnd = random_done;
 
endmodule
