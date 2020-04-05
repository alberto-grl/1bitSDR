module PWM
(input clk,
input [11:0] DataIn,
output reg PWMOut
);

reg [9:0] counter;
reg [11:0] SimIn;
reg [11:0] DataInNoSign;
reg [11:0] DataInReg;
/*

always @(posedge clk)
	begin
		if (counter == 255)
			SimIn <= SimIn +1;
		else
			SimIn <= SimIn;
	end;

*/

always @(posedge clk)
	begin
		counter <= counter + 1'b 1;
		if (counter == 0)
			DataInReg <= DataIn+  10'd 512;
//			DataInNoSign <= DataIn +  12'd 2048;
	
//		if (counter > (DataInNoSign))  //DataIn is signed
		if (counter > (DataInReg[9:0])) 
			PWMOut <= 1'b 0;
		else
			PWMOut <= 1'b 1;
	end
	
endmodule