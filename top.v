
module top 
  (
   input    i_Rx_Serial,
   input Reset,
   output o_Tx_Serial,
   output   o_Rx_DV,
   output[7:0] o_Rx_Byte,
   	output [7:0] MYLED,
	
	input wire In0
   );

  wire osc_clk;
 reg TXDelayed;
 reg StartTXCount;
reg [31:0] DelayCounter; 
wire [7:0] i_Tx_Byte;

  
//// Internal Oscillator
	defparam OSCH_inst.NOM_FREQ = "133.00";
	OSCH OSCH_inst
		( 
		.STDBY(1'b0), 		// 0=Enabled, 1=Disabled also Disabled with Bandgap=OFF
		.OSC(osc_clk),
		.SEDSTDBY()     		// this signal is not required if not using SED
		);

	
	GSR GSR_INST (.GSR (Reset));
	
	TestFifo TestFifo1 (
	.Data (o_Rx_Byte),
	.Q (i_Tx_Byte),
	.WrEn (o_Rx_DV),
	.RdEn (TXDelayed),
	.WrClock (osc_clk),
	.RdClock (osc_clk),
	.Reset (Reset),
	.RPReset (Reset)
	);
	
	
	
uart_rx  #(.CLKS_PER_BIT(1155))  uart_rx1 (
.osc_clk (osc_clk), 
.i_Rx_Serial (i_Rx_Serial),
.o_Rx_DV  (o_Rx_DV),
.o_Rx_Byte (o_Rx_Byte)
);
	
always @ (posedge osc_clk)
	begin
		
		if (o_Rx_DV)
			begin
					StartTXCount <= 1;
			end
		else
			begin
					StartTXCount <= StartTXCount;
			end
			
				
		
		if (DelayCounter == 266000000)
			begin
				DelayCounter <= 0;
				 TXDelayed <= 1;
				 StartTXCount <= 0;
			end
		else
			begin
				if (StartTXCount == 1)
					begin
				       DelayCounter <= DelayCounter +1;
					end
				else
					begin
				       DelayCounter <= DelayCounter;
					end
				 TXDelayed <= 0;			end	end
	
uart_tx  #(.CLKS_PER_BIT(1155))  uart_tx1 (
.osc_clk (osc_clk), 
.o_Tx_Serial (o_Tx_Serial),
.i_Tx_DV  (TXDelayed),
.i_Tx_Byte (i_Tx_Byte),
.o_Tx_Active (o_Tx_Active),
.o_Tx_Done (o_Tx_Done)
);	
	
	
	
blinking_led blinking_led1 (
.MYLED (MYLED),
.In0 (In0),
.osc_clk (osc_clk)
);


/*test test1 (
 .osc_clk    (osc_clk),
   .i_Rx_Serial (i_Rx_Serial),
  .o_Rx_DV (o_Rx_DV)
   );
*/
endmodule
