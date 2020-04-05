 


module MixerSim(); 
  reg osc_clk, RFIn;
  reg signed [7:0] LOSine, LOCosine;
   wire DiffOut;
  wire signed [7:0] MixerOutSin;
  wire signed [7:0] MixerOutCos;




Mixer Mixer1 (
.clk (osc_clk),
.RFIn (RFIn),
.sin_in (LOSine),
.cos_in (LOCosine),
.RFOut (DiffOut),
.MixerOutSin (MixerOutSin),
.MixerOutCos (MixerOutCos)
);

initial
begin
	osc_clk = 0;
	RFIn = 0;
	LOSine = 0;
	LOCosine = 80;	  
	#20 RFIn = 1;
	#30 LOSine = 20;
end

always
	#5 osc_clk <= !osc_clk;

endmodule
