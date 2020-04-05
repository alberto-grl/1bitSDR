
module frequency_select
			(input wire               clk,
			input wire [7:0]  rx_char,
			output reg [63:0]  PLL_inc
			);


	always @(posedge clk)
	begin
		
      case (rx_char)
        8'd 48 :
          begin
			  // tasto 0
			PLL_inc <= 64'h 1B1B1B1B1B1B1B1;
          end

        8'd 49 :
          begin
			  //tasto 1
			PLL_inc <= 64'h 104376A9DD10437;
          end 
		 8'd 50 :
          begin
			  //tasto 1
			PLL_inc <= 64'h 19c0268cf359c02;
          end 
		  8'd 51 :
          begin
			  //tasto 1
			PLL_inc <= 64'h 1d00d7e21f90340;
          end 
		  default :
          begin
			  //tasto 1
			PLL_inc <= 64'h 1B1B1B1B1B1B1B1;
          end 
        endcase 
	end
		
endmodule