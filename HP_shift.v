// https://www-users.cs.york.ac.uk/~fisher/mkfilter/
// http://www.micromodeler.com/dsp/
//https://dspguru.com/dsp/tricks/fixed-point-dc-blocking-filter-with-noise-shaping/


module HP_shift
			(input wire               clk,
			input wire signed [7:0]  d_in,
			output wire signed [7:0]  d_out
			);
reg signed [31:0]  DCLevel;	
wire signed [31:0] Acc;
wire clk_divided;
reg  [31:0] clk_counter;

 //Filter clock is 33203.125 Hz when master clock is 136 MHz and decimation is 4096

always @(posedge clk)
	begin
		clk_counter <= clk_counter + 1'b1; 		
	end
assign clk_divided = clk_counter[16];	
assign d_out = d_in - DCLevel[31:24];
assign Acc = (d_out<<<24) + DCLevel;
	always @(posedge clk_divided)
	begin
		DCLevel <= Acc; 		
	end

endmodule