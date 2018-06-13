`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/05/2018 11:07:39 PM
// Design Name: 
// Module Name: putting
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


module putting(
	input wire clk, rst,
	input wire mouse_left,
	input wire empty,
	input wire [3:0] column_in, row_in,
	
	output reg [3:0] column_out_r, row_out_r,
	output reg [3:0] column_out_d, row_out_d,
	output reg follow_ball,
	output reg back_ball,
	output reg putting_end,
	output reg delete
);

localparam 	IDLE 	= 3'b000, 
			SELECT 	= 3'b001,
			PUTT 	= 3'b010,
			BACK 	= 3'b011,
			END 	= 3'b100;
			
localparam	BALL_SIZE = 50;
	
	reg [2:0] state_nxt, state;
	reg [3:0] col_temp, row_temp, col_d, row_d, col_r, row_r;
	
always @(posedge clk)
begin
	if(rst) begin
        delete <= 0;
        follow_ball <= 0;
        putting_end <= 0;
	end
	else begin
		state <= state_nxt;
		column_out_d <= col_d;
		row_out_d <= row_d;
		column_out_r <= col_r;
        row_out_r <= row_r;
		
	end
end



always @* begin
	case(state)
		IDLE:   state_nxt = mouse_left ? SELECT : IDLE;	
		SELECT:	begin
                if(!mouse_left)
                    state_nxt = empty ? PUTT : BACK;
                else state_nxt = SELECT;
                end
        PUTT:	state_nxt = END;
        BACK: 	state_nxt = IDLE;
        END:	state_nxt = IDLE;
        default:	state_nxt = IDLE;
		endcase
	end
	
	
	always @* begin	
		case(state)
			IDLE: begin
			    follow_ball = 1'b0;
			    delete = 1'b0;
			    putting_end = 1'b0;
//			    col_temp = column_in;
//                row_temp = row_in;
			    end
			SELECT:	begin
				if(!empty) begin
					follow_ball = 1'b1;
					delete = 1'b1;
					col_d = column_in;
                    row_d = row_in;
					end
				else state_nxt = IDLE;
				end		
			PUTT: begin
				 back_ball = 1'b0;
				 col_r = column_in;
				 row_r = row_in;
			     end
			BACK: begin
				 back_ball = 1'b1;
				 //state_nxt = IDLE;
			     end
			END: begin
			     putting_end = 1'b1;		
			     end
		endcase
	end	
endmodule
