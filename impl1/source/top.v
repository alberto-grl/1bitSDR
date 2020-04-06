/*
1Bit FPGA SDR.

Lattice MachXO2 receiver for long and medium wave. 
Main goal was to use as little components as possible.
Just a Lattice breakout board, https://www.latticesemi.com/en/Products/DevelopmentBoardsAndKits/MachXO2BreakoutBoard
four resistors, three capacitors and a crystal oscillator. No tuned circuits, no external ADC.
An LVDS input is connected directly to the antenna. The other input is wired like a LVDS sigma-delta modulator,
but it works in a different way. It does not track the radio signal, its frequency would be too high.
It (relatively) slowly keeps the DC level of the second input in the middle of hysteresis dead band.
Sampling is performed by the random noise at the antenna.
Highest frequency station that was received is Radio China International, 7145 KHz, transmitting from north western China.
The antenna I used for my tests is just a 20 meter wire hanging on the roof, Again, no preamplifier was used.

If you are willing to add to this bare minimum, I would suggest a 4700 pF cap series connected to the antenna, and a 100 uF 
series connected to the speaker.
A crystal oscillator is a useful addition, audio quality and sensitivity are better.
Also, the internal oscillator is specified at +- 5% and this can make tuning harder.



No input limiting circuit is implemented, static charges or a high RF environment could damage the board.
Nighttime, spring reception from northern Italy brought about 10 MW and two LW stations from Europe and Africa.
Performance of the receiver is obviously limited, it is a good starting point for learning about FPGA and SDR.

Control of RX frequency and RF gain is by the second USB to UART interface of the board, the first is used for programming.
This UART needs to by connected to the FPGA with a solder jumper, see the board documentation.



TODO: FIR filter after CIC
TODO: SSB demodulator
TODO: Real user inteface
*/ 

// IP Express reference : https://www.latticesemi.com/-/media/LatticeSemi/Documents/UserManuals/EI2/FPGA-IPUG-02032-1-0-Arithmetic-Modules.ashx?document_id=52235



`define CLOCK_IS_83_MHZ
// `define CLOCK_IS_80_MHZ



module top 
  (
   input    i_Rx_Serial,
   output o_Tx_Serial,
   	output [7:0] MYLED,
	`ifdef CLOCK_IS_80_MHZ 
	input XIn,
	`endif
	output XOut,
	input  RFIn, 
	output DiffOut,
	output PWMOut,	
	output PWMOutP1,
	output PWMOutP2,
	output PWMOutP3,
	output PWMOutP4,
	output PWMOutN1,
	output PWMOutN2,
	output PWMOutN3,
	output PWMOutN4,
	output sinGen,
	output sin_out,
	output CIC_out_clkSin
   );
  wire osc_clk;
reg [31:0] DelayCounter; 
wire [7:0] i_Tx_Byte;
reg o_Rx_DV;
reg[7:0] o_Rx_Byte;

wire o_Rx_DV1;
wire[7:0] o_Rx_Byte1;

reg [63:0] phase_inc_carr;
//wire  sin_out, cos_out;
wire  cosGen;
wire signed [11:0] MixerOutSin;
wire signed [11:0] MixerOutCos;
wire signed [11:0] CIC_outSin;
wire signed [11:0] CIC1_outSin;
wire CIC1_out_clkSin;
wire signed [11:0] CIC_outCos;
wire signed [11:0] CIC1_outCos;
wire CIC1_out_clkCos;
wire [63:0] phase_accum;
wire signed [12:0] LOSine;
wire signed [12:0] LOCosine;
reg signed [63:0] NCO_PLL_Accum;
reg signed [63:0] phase_inc_carrGen;
reg signed [63:0] phase_inc_carrGen1;
wire signed [31:0] CarrierPLL_out;

wire signed [11:0] DemodOut;

reg [7:0] CICGain;

/*
 Valid values are 2.08,2.15,2.22,2.29,2.38,2.46,2.56,2.66,2.77,2.89,3.02,3.17,3.33,3.50,3.69,3.91,4.16,
 4.29,4.43,4.59,4.75,4.93,5.12,5.32,5.54,5.78,6.05,6.33,6.65,7.00,7.39,7.82,8.31,8.58,8.87,9.17,9.50,9.85,
 10.23,10.64,11.08,11.57,12.09,12.67,13.30,14.00,14.78,15.65,16.63,17.73,19.00,20.46,22.17,24.18,26.60,
 29.56,33.25,38.00,44.33,53.20,66.50,88.67,133.00 MHz. 

*/

//// Internal Oscillator - 88.67 oscillates at about 83 MHz on my board

`ifdef CLOCK_IS_83_MHZ 
	defparam OSCH_inst.NOM_FREQ = "88.67";
	OSCH OSCH_inst
		( 
		.STDBY(1'b0), 		// 0=Enabled, 1=Disabled also Disabled with Bandgap=OFF
		.OSC(osc_clk),
		.SEDSTDBY()     		// this signal is not required if not using SED
		);
`endif
	
//	GSR GSR_INST (.GSR (1'b1));


PUR PUR_INST    (.PUR(1'b1));

// inc = 2^64 * Fout / Fclock
// Python: print(hex(pow(2,64) * 1359000 // 80000000))



assign PWMOutP1 = PWMOut;
assign PWMOutP2 = PWMOut;
assign PWMOutP3 = PWMOut;
assign PWMOutP4 = PWMOut;
assign PWMOutN1 = !PWMOut;
assign PWMOutN2 = !PWMOut;
assign PWMOutN3 = !PWMOut;
assign PWMOutN4 = !PWMOut;


SinCos SinCos1 (
.Clock (osc_clk),
.ClkEn (1'b 1),
.Reset (1'b 0),
.Theta (phase_accum[63:56]),
.Sine (LOSine),
.Cosine (LOCosine)
);
	

nco_sig	 ncoGen (
.clk (osc_clk),
.phase_inc_carr ( phase_inc_carrGen1),
.phase_accum (phase_accum),
.sin_out (sinGen),
.cos_out (cosGen)
);

	
Mixer Mixer1 (
.clk (osc_clk),
.RFIn (RFIn),
.sin_in (LOSine[12:1]),
.cos_in (LOCosine[12:1]),
.RFOut (DiffOut),
.MixerOutSin (MixerOutSin),
.MixerOutCos (MixerOutCos)
);


CIC  #(.width(72), .decimation_ratio(4096)) CIC1Sin (
.clk (osc_clk),
.Gain (CICGain),
.d_in (MixerOutSin),
.d_out (CIC1_outSin),
.d_clk (CIC1_out_clkSin)
);  


CIC  #(.width(72), .decimation_ratio(4096)) CIC1Cos (
.clk (osc_clk),
.Gain (CICGain),
.d_in (MixerOutCos),
.d_out (CIC1_outCos),
.d_clk (CIC1_out_clkCos)
);  


PWM PWM1 (
.clk (osc_clk),
//.DataIn (IIR_out), //(CIC_out),
.DataIn (DemodOut), //(IIR_out),
//.DataIn (CIC1_outCos),
.PWMOut (PWMOut)
);

`ifdef CLOCK_IS_80_MHZ 
PLL PLL1 (
.CLKI (),.CLKOP (osc_clk)
);
`endif
	  
//assign MYLED[5:0] = MixerOutSin[7:2];
assign MYLED[5:0] = CIC1_outSin [11:6];
//assign MYLED[5:0] = DemodOut [11:6];
//assign MYLED[5:0] = o_Rx_Byte [7:2];
//assign MYLED[7] = CarrierPLL_out[31];
//assign MYLED[6] = cos_out; 
//assign MYLED[7:6] = CIC1_outSin [11:10];
assign MYLED[6] = o_Rx_Byte [1];

AMDemodulator AMDemodulator1
(
CIC1_out_clkSin,
CIC1_outSin ,
CIC1_outCos ,
DemodOut); 

//CLKS_PER_BIT(87) -> 115200 @ 80MHz 
uart_rx  #(.CLKS_PER_BIT(87))  uart_rx1 (
.osc_clk (osc_clk), 
.i_Rx_Serial (i_Rx_Serial),
.o_Rx_DV  (o_Rx_DV1),
.o_Rx_Byte (o_Rx_Byte1)
);
	
/*
uart_tx  #(.CLKS_PER_BIT(87))  uart_tx1 (
.osc_clk (osc_clk), 
.o_Tx_Serial (o_Tx_Serial),
.i_Tx_DV  (o_Rx_DV),
.i_Tx_Byte (o_Rx_Byte),
.o_Tx_Active (o_Tx_Active),
.o_Tx_Done (o_Tx_Done)
);	
*/

always @ (posedge osc_clk)
	begin
	phase_inc_carrGen1 <= phase_inc_carrGen;	
	
	o_Rx_DV <= o_Rx_DV1;
    o_Rx_Byte <= o_Rx_Byte1;
	
	if (o_Rx_DV)
		begin
	
 case (o_Rx_Byte)
    7'd48  : CICGain <= 7'd0; // 0
    49  : CICGain <= 7'd1; // 1
	50  : CICGain <= 7'd2; // 2
	51  : CICGain <= 7'd3; // 3
 endcase
   
`ifdef CLOCK_IS_80_MHZ 
   case (o_Rx_Byte)
    97  : phase_inc_carrGen <= 64'h 2e147ae147ae147; //a Siziano 900 KHz
    98  : phase_inc_carrGen <= 64'h 1ba5e353f7ced91; //b Kossuth Budapest 540 KHz
	99  : phase_inc_carrGen <= 64'h 2bc6a7ef9db22d0; //c Romania Actualitati 855 KHz
	100  : phase_inc_carrGen <= 64'h bfb15b573eab36; //d RTL R. Luxembourg 234 KHz
	101  : phase_inc_carrGen <= 64'h 4f41f212d77318f; //e Voice of Russia / Capital gold radio 1548 KHz
	102  : phase_inc_carrGen <= 64'h 3be76c8b4395810; //f Capodistria 1170 KHz
	103  : phase_inc_carrGen <= 64'h 37c1bda5119ce07; //g Talk Sport Radio 1089 KHz
	110 :  phase_inc_carrGen <= phase_inc_carrGen - 64'h 75f6fd21ff2e4 ; //n - 9KHz
	109 :  phase_inc_carrGen <= phase_inc_carrGen + 64'h 75f6fd21ff2e4 ; //m + 9 KHz 
  endcase
`endif	

	
`ifdef CLOCK_IS_83_MHZ
   case (o_Rx_Byte)
    97  : phase_inc_carrGen <= 64'h 2c6a19e88f1cfe2; //a Siziano 900 KHz
    98  : phase_inc_carrGen <= 64'h 1aa60f8b8911654; //b Kossuth Budapest 540 KHz
//	99  : phase_inc_carrGen <= 64'h 2bc6a7ef9db22d0; //c Romania Actualitati 855 KHz
//	100  : phase_inc_carrGen <= 64'h bfb15b573eab36; //d RTL R. Luxembourg 234 KHz
//	101  : phase_inc_carrGen <= 64'h 4f41f212d77318f; //e Voice of Russia / Capital gold radio 1548 KHz
	102  : phase_inc_carrGen <= 64'h 1dc38c076704516d; //f 9650 KHz
	103  : phase_inc_carrGen <= 64'h 1d60d923295482c6; //g Radio China 9525 KHz
	110 :  phase_inc_carrGen <= phase_inc_carrGen - 64'h 71b375868d170 ; //n - 9KHz
	109 :  phase_inc_carrGen <= phase_inc_carrGen + 64'h 71b375868d170 ; //m + 9KHz 
	111 :  phase_inc_carrGen <= phase_inc_carrGen - 64'h 1436a8cdf6f3  ; //o - 100 Hz
	112 :  phase_inc_carrGen <= phase_inc_carrGen + 64'h 1436a8cdf6f3 ; //p + 100 Hz 
	113 :  phase_inc_carrGen <= phase_inc_carrGen - 64'h ca22980ba57e6 ; //q - 1KHz
	104 :  phase_inc_carrGen <= phase_inc_carrGen + 64'h ca22980ba57e6 ; //r + 1 KHz 
  endcase
`endif		
  end
end
	

endmodule
