// blinking _led.v


//////////////////////// LED Blinker Using On-Chip Osc /////////////////////////////
//***********************************************************************
// FileName: blinking _led.v
// FPGA: MachXO2 7000HE
// IDE: Diamond 2.0.1 
//
// HDL IS PROVIDED "AS IS." DIGI-KEY EXPRESSLY DISCLAIMS ANY
// WARRANTY OF ANY KIND, WHETHER EXPRESS OR IMPLIED, INCLUDING BUT NOT
// LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
// PARTICULAR PURPOSE, OR NON-INFRINGEMENT. IN NO EVENT SHALL DIGI-KEY
// BE LIABLE FOR ANY INCIDENTAL, SPECIAL, INDIRECT OR CONSEQUENTIAL
// DAMAGES, LOST PROFITS OR LOST DATA, HARM TO YOUR EQUIPMENT, COST OF
// PROCUREMENT OF SUBSTITUTE GOODS, TECHNOLOGY OR SERVICES, ANY CLAIMS
// BY THIRD PARTIES (INCLUDING BUT NOT LIMITED TO ANY DEFENSE THEREOF),
// ANY CLAIMS FOR INDEMNITY OR CONTRIBUTION, OR OTHER SIMILAR COSTS.
// DIGI-KEY ALSO DISCLAIMS ANY LIABILITY FOR PATENT OR COPYRIGHT
// INFRINGEMENT.
//
// Version History
// Version 1.0 04/5/2013 Tony Storey
// Initial Public Release
// Small Footprint Button Debouncer


////	The default frequency is 2.08MHz.  Supported frequencies (in MHz) include:
////	2.08        4.16         8.31          15.65
////	2.15        4.29         8.58          16.63
////	2.22        4.43         8.87          17.73
////	2.29        4.59         9.17          19.00
////	2.38        4.75         9.50          20.46
////	2.46        4.93         9.85          22.17
////	2.56        5.12        10.23         24.18
////	2.66        5.32        10.64         26.60
////	2.77        5.54        11.08         29.56
////	2.89        5.78        11.57         33.25
////	3.02        6.05        12.09         38.00
////	3.17        6.33        12.67         44.33
////	3.33        6.65        13.30         53.20
////	3.50        7.00        14.00         66.50
////	3.69        7.39        14.78         88.67
////	3.91        7.82        15.65       133.00


module blinking_led 
	(
	output reg [7:0] MYLED,
	input wire In0,
	input wire osc_clk
	);
//// ---------------- internal constants --------------
	parameter 		N= 28;	// sets counter size
////---------------- internal variables ---------------
	reg [N-1 : 0] 	count;
	reg Bit0;

	
//// ------------------------------------------------------

/*//// Internal Oscillator
	defparam OSCH_inst.NOM_FREQ = "133.00";
	OSCH OSCH_inst
		( 
		.STDBY(1'b0), 		// 0=Enabled, 1=Disabled also Disabled with Bandgap=OFF
		.OSC(osc_clk),
		.SEDSTDBY()     		// this signal is not required if not using SED
		);
*/

//// counter with no flag control
	always @ (posedge osc_clk)
		
		begin
			if(count < {8'h 79, {N-7{1'h 0}}})
				begin
						count <= count + 1'b1;
				end
			else
				begin
					count <= {N {1'h0} };
				end
		end
		

////4-8 data encoder ROM
	always @ ( count[N-1:N-2] )
		begin
			case( count[N-1:N-2])
				2'b 01	:	
				begin
						MYLED[3:0] <= ~4'b 1000;
						Bit0 <=1'b1;
				end
				2'b 10	:
				begin	
				        MYLED[3:0] <= ~4'b 1010;
						Bit0 <=1'b0;
				end
				2'b 11	:	
				begin
						MYLED[3:0] <= ~4'b 1110;
						Bit0 <=1'b0;
				end
				2'b 00	:
				begin
						MYLED[3:0] <= ~4'b 1111;
						Bit0 <=1'b0;
				end
							
				default 	:
				begin
						MYLED[3:0] <= ~4'b 0000;
						Bit0 <=1'b0;
				end
			endcase
			MYLED[4] <= 1'b 0;
			MYLED[5] <= 1'b 0;
		end

	always @ (posedge osc_clk)
		begin
			if(Bit0 ==1'b1)
				begin
						MYLED[7] <= 1'b1;
				end
			else
				begin
					MYLED[7] <= 1'b0;
				end
		end


	always @ (posedge osc_clk)
		begin
					MYLED[6] <= In0;
		end
		
endmodule			
	
			
