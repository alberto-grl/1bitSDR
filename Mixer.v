
module Mixer
  (clk,
   RFIn,
   sin_in,
   cos_in,
   RFOut,
   MixerOutSin,
   MixerOutCos
  );


  input clk;
  input signed [11:0] sin_in;
  input signed [11:0] cos_in;
  input RFIn;
  output RFOut;
  output reg signed [11:0] MixerOutSin;
  output reg signed [11:0] MixerOutCos;
  reg  RFInR1 = 1'b1;
  reg  RFInR = 1'b1;

  always @(posedge clk)
    begin 
      RFInR1 <= RFIn;
      RFInR <= RFInR1;	
    end

  assign RFOut = RFInR1;


  always @(posedge clk)
    begin
      if (RFInR == 1'b 0)
        begin
          MixerOutSin <= sin_in;
          MixerOutCos <= cos_in;
        end
      else
        begin
          MixerOutSin <= -sin_in;
          MixerOutCos <= -cos_in;				
        end
    end

endmodule