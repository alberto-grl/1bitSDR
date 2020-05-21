module system_monitor  # ( // one per PLL
            parameter            CLOCKS = 2)
(
   input    logic                   clock,
   input    logic [CLOCKS-1:0]      pll_clocks,
   input    logic                   pll_locked,
   output   logic                   pll_areset,
   output   logic [CLOCKS-1:0]      pll_sreset);   // synchronous resets with delay
   
            logic [15:0]            counter = 16'h0;
            logic [2:0]             pll_locked_meta;
            logic [CLOCKS-1:0][2:0] sreset_meta;
            logic                   pll_areset_flop;
   
   // assumption here is that locked PLL will fail more often than incoming board clock
   always_ff @ (posedge clock) begin
      pll_locked_meta <= {pll_locked_meta[1:0], pll_locked};
      if (&counter) begin
         if (~pll_locked_meta[2]) begin
            pll_areset <= 1'b1;
            counter <= 16'h0;
         end
         else
            pll_areset <= 1'b0;
      end
      else begin
         pll_areset <= 1'b0;
         counter <= counter + 16'h1;
      end
      pll_areset_flop <= pll_areset | (~&counter);
   end
   
   genvar i;
   generate
      for (i=0; i<CLOCKS; i=i+1) begin : sync_reset_gen
         always_ff @ (posedge pll_clocks[i]) begin
            sreset_meta[i][0] <= pll_areset_flop; // sample asynch pll reset to each clock domain and create synch reset
            sreset_meta[i][1] <= sreset_meta[i][0];
            sreset_meta[i][2] <= sreset_meta[i][1];
            pll_sreset[i] <= sreset_meta[i][2];
         end
      end
   endgenerate
   
endmodule
