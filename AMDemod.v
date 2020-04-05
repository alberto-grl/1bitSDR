
/* Performs AM Demodulation. sqrt( I^2 + Q^2) 
Square root code is taken from https://verilogcodes.blogspot.com/2017/11/a-verilog-function-for-finding-square-root.html

TODO: use only one multiplier with TDM
TODO: minimize rounding errors of sqrt, get fractional result by scaling input
*/
module AMDemodulator
  (
    clk,
    I_in ,
    Q_in ,
    d_out); 
  //	   PUR PUR_INST(.PUR (1'b1));


  input clk;  
  input signed [11:0] I_in;
  input signed [11:0] Q_in;
  reg signed [15:0] d_out_d;
  output reg [11:0] d_out;
  reg [1:0] state;
  reg NewSample;
  reg [31:0] ISquare;
  reg [15:0] QSquare;
  reg [15:0] SquareSum;

  reg signed [11:0] MultDataA;
  reg signed [11:0] MultDataB;
  wire signed [23:0] MultResult1;


  reg signed [11:0] MultDataC;
  reg signed [11:0] MultDataD;
  wire signed [23:0] MultResult2;

  function [15:0] sqrt;
    input [31:0] num;  //declare input
    //intermediate signals.
    reg [31:0] a;
    reg [15:0] q;
    reg [17:0] left,right,r;    
    integer i;
    begin
      //initialize all the variables.
      a = num;
      q = 0;
      i = 0;
      left = 0;   //input to adder/sub
      right = 0;  //input to adder/sub
      r = 0;  //remainder
      //run the calculations for 16 iterations.
      for(i=0;i<16;i=i+1) begin 
        right = {q,r[17],1'b1};
        left = {r[15:0],a[31:30]};
        a = {a[29:0],2'b00};    //left shift by 2 bits.
        if (r[17] == 1) //add if r is negative
          r = left + right;
        else    //subtract if r is positive
          r = left - right;
        q = {q[14:0],!r[17]};       
      end
      sqrt = q;   //final assignment of output.
    end
  endfunction //end of Function



  Multiplier Multiplier1 (.Clock (clk),
                          .ClkEn (1'b 1),
                          .Aclr (1'b 0),
                          .DataA (MultDataA),
                          .DataB (MultDataB),
                          .Result (MultResult1)
                         );

  Multiplier Multiplier2 (.Clock (clk),
                          .ClkEn (1'b 1),
                          .Aclr (1'b 0),
                          .DataA (MultDataC),
                          .DataB (MultDataD),
                          .Result (MultResult2)
                         );


  always@(posedge clk) begin

    MultDataA <= I_in;
    MultDataB <= I_in;
    MultDataC <= Q_in;
    MultDataD <= Q_in;
    ISquare <= MultResult1 + MultResult2;
    d_out_d <= sqrt(ISquare);
    d_out <= d_out_d[11:0];
  end


endmodule