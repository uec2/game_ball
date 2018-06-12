module odczyt_wspol_myszki (
	input wire clk, rst,
	//input wire released,
	//input wire [2:0] color,
	input  wire [11:0] xpos, ypos,
	//input wire [3:0] random_c, random_r,
	
	output reg [3:0] column, row
	);
	
localparam	UP = 32,
			LEFT = 256,
			SQUARE_SIZE = 64;

reg [6:0] column_nxt, row_nxt, col_nxt, r_nxt, xpos_nxt, ypos_nxt;
reg [2:0] color_nxt;


	always @(posedge clk)
		begin
			if(rst) begin
				column <= 0;
				row <= 0;
				//color <= color_nxt;
			end
			else begin
				column <= column_nxt;
				row <= row_nxt;
				//color <= color_nxt;
			end
		end

	always @*
	begin
		xpos_nxt = xpos - LEFT;
		ypos_nxt = ypos - UP;
		col_nxt = xpos_nxt[9 : 6] + 1;
		r_nxt = ypos_nxt[9:6] + 1;
//		column_nxt = released ? col_nxt : random_c;
//		row_nxt = released ? r_nxt : random_r;
	end
endmodule
