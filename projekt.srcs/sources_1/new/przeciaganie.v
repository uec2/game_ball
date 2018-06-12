module przeciaganie (
	input wire clk, rst,
	input wire mouse_left,
	input wire [11:0] mouse_xpos, mouse_ypos,
	input wire [63:0] ball_reg_in,
	input wire empty,
	input wire [3:0] column, row,
	
	output reg [11:0] xpos_out, ypos_out,
	//output reg released,
	output reg follow_ball,
	output reg [63:0] ball_reg_out,
	output reg back_ball,
	output reg putting_end,
	output reg record
);

localparam 	IDLE 	= 3'b000, 
			SELECT 	= 3'b001,
			PUTT 	= 3'b010,
			BACK 	= 3'b011,
			END 	= 3'b100;
			
localparam	BALL_SIZE = 50;
	
	reg xpos_nxt, ypos_nxt, xpos_temp, ypos_temp, state_nxt, state;
	// , state_nxt, hcount_temp, vcount_temp, vblnk_temp, hblnk_temp, rgb_pixel;
	
	
	
always @(posedge clk)
begin
	if(rst) begin
		xpos_out <= 0;
		ypos_out <= 0;
		//rgb_out <= 0;
        follow_ball <= 0;
	end
	else begin
		xpos_out <= xpos_nxt;
		ypos_out <= ypos_nxt;
		//rgb_out <= rgb_out_nxt;
		state <= state_nxt;
	end
end

always @* begin
	case(state)
		IDLE:	state_nxt = mouse_left ? SELECT : IDLE;
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
			    follow_ball = 0;
//				xpos_nxt = xpos_out;
//				ypos_nxt = xpos_out;
			end
			SELECT:	begin
				if(!empty) begin
//					xpos_temp = mouse_xpos;
//					ypos_temp = mouse_ypos;
					follow_ball = 1'b1;
//					if((hcount_temp >= xpos) && (hcount_temp <= xpos + BALL_SIZE) &&
//						(vcount_temp >= ypos) && (vcount_temp <= ypos +BALL_SIZE) &&
//						!(vblnk_temp || hblnk_temp))
//					   begin
//						  rgb_out_nxt <= rgb_pixel;
//					   end
//						xpos_nxt <= mouse_xpos;
//						ypos_nxt <= mouse_ypos;	
					end
				else state_nxt = IDLE;
				end
					
			PUTT: begin
				//released <= 1;
//				xpos_nxt <= mouse_xpos;
//				ypos_nxt <= mouse_ypos;
				back_ball = 0;
				record =1;
				//usuwanie i wpisywanie
			end
			BACK: begin
				//released <= 0;
				// nie zmieniaj rejestru
//				xpos_nxt <= xpos_temp;
//				ypos_nxt <= ypos_temp;
				state_nxt = IDLE;
				back_ball = 1;
			end
			END: begin
			    putting_end = 1;
				state_nxt = IDLE;			
			end
		endcase
	end	
endmodule
