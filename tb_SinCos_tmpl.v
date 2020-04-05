//Verilog testbench template generated by SCUBA Diamond (64-bit) 3.11.0.396.4
`timescale 1 ns / 1 ps
module tb;
    reg Clock = 0;
    reg ClkEn = 0;
    reg Reset = 0;
    reg [7:0] Theta = 8'b0;
    wire [12:0] Sine;
    wire [12:0] Cosine;

    integer i0 = 0, i1 = 0, i2 = 0, i3 = 0, i4 = 0, i5 = 0;

    GSR GSR_INST (.GSR(1'b1));
    PUR PUR_INST (.PUR(1'b1));

    SinCos u1 (.Clock(Clock), .ClkEn(ClkEn), .Reset(Reset), .Theta(Theta), 
        .Sine(Sine), .Cosine(Cosine)
    );

    always
    #5.00 Clock <= ~ Clock;

    initial
    begin
       ClkEn <= 1'b0;
      #100;
      @(Reset == 1'b0);
       ClkEn <= 1'b1;
    end
    initial
    begin
       Reset <= 1'b1;
      #100;
       Reset <= 1'b0;
    end
    initial
    begin
       Theta <= 0;
      #100;
      @(Reset == 1'b0);
      for (i4 = 0; i4 < 259; i4 = i4 + 1) begin
        @(posedge Clock);
        #1  Theta <= Theta + 1'b1;
      end
    end
endmodule