// https://www.embedded.com/design/configurable-systems/4006446/Understanding-cascaded-integrator-comb-filters
// https://github.com/ericgineer/CIC/blob/master/CIC.v
// https://westcoastdsp.wordpress.com/tag/cic-filter/
// https://www.dsprelated.com/thread/907/cic-filter
// http://home.mit.bme.hu/~kollar/papers/cic.pdf

/*
or a Q-stage CIC decimation-by-D filter (diff delay = 1) overflow errors are avoided if the number of
integrator and comb register bit widths is at least
register bit widths = number of bits in x(n) + {Qlog2(D)}
where x(n) is the input to the CIC filter, and {k} means that if k is not an integer,
round it up to the next larger integer. 
For example, if a Q = 3-stage CIC decimation filter accepts one-bit binary input words from a
sigma-delta A/D converter and the decimation factor is D = 64, binary overflow errors are
avoided if the three integrator and three comb registers’ bit widths are no less than
    register bit widths = 1 + {3 log2(D)} = 1 + 3 6 = 19 bits.
	5 stadi, decimation 16384 (14 bit) 1 + 5 * 14 = 71 
*/
module cic_filter # (
            parameter                   WIDTH = 16,     // input width
            parameter                   STAGES = 5,     // CIC stages
            parameter                   DDELAY = 1,     // differential delay
            parameter                   DECIMATION = 4096,
            parameter                   WIDTHR = 16     // result width
)
(
    input   logic                       clock,
    input   logic                       clock_sreset,
    input   logic [3:0]                 gain,
    input   logic                       data_in_valid,
    input   logic signed [WIDTH-1:0]    data_in,
    output  logic                       data_out_valid,
    output  logic signed [WIDTHR-1:0]   data_out
);
            localparam                  WIDTHO = WIDTH + (STAGES * $clog2(DECIMATION * DDELAY));
            localparam                  WIDTHZ = WIDTHO * WIDTH;
            localparam                  ZERO = {WIDTHZ{1'b0}};
            localparam                  ONE = {ZERO, 1'b1};
            localparam                  DONTCARE = {WIDTHZ{1'bx}};
            
            localparam                  WIDTHC = $clog2(DECIMATION);
            
            integer                     i, j;
            
            logic signed [WIDTHO-1:0]   idata_reg[STAGES-1:0];
            logic signed [WIDTHO-1:0]   cdata_reg[DDELAY-1:0][STAGES-1:0];
            logic signed [WIDTHO-1:0]   sub_node[STAGES-1:0];
            logic [WIDTHC-1:0]          decimation_count;
            logic                       comb_enable;
            wire signed [WIDTHO-1:0]    result = sub_node[STAGES-1] >>> (WIDTHO - WIDTHR - gain);
            wire                        end_decimation_count = decimation_count >= (DECIMATION[WIDTHC-1:0] - ONE[WIDTHC-1:0]);
            
    initial begin
        $display("Output Width : %d", WIDTHO);
    end

    // integrate, decimate
    always_ff @ (posedge clock) begin
        if (clock_sreset) begin // handle synchronous reset
            for (i=0; i<STAGES; i++) begin
                idata_reg[i] <= DONTCARE[WIDTHO-1:0];
            end
            decimation_count <= ZERO[WIDTHC-1:0];
            comb_enable <= 1'b0;
        end
        else begin
            if (data_in_valid) begin
                // integrate
                for (i=0; i<STAGES; i++) begin
                    if (i == 0) begin
                        idata_reg[0] <= idata_reg[i] + data_in;
                    end
                    else begin
                        idata_reg[i] <= idata_reg[i] + idata_reg[i-1];
                    end
                end
                
                // decimation counter
                comb_enable <= end_decimation_count;
                if (end_decimation_count) begin
                    decimation_count <= ZERO[WIDTHC-1:0];
                end
                else begin
                    decimation_count <= decimation_count + ONE[WIDTHC-1:0];
                end
            end
            else begin
                comb_enable <= 1'b0;
            end
        end
    end
    
    // comb
    always_ff @ (posedge clock) begin
        if (clock_sreset) begin
            data_out_valid <= 1'b0;
            data_out <= DONTCARE[WIDTHR-1:0];
            for (i=0; i<STAGES; i++) begin
                sub_node[i] <= DONTCARE[WIDTHO-1:0];
                for (j=0; j<DDELAY; j++) begin
                    cdata_reg[j][i] <= DONTCARE[WIDTHO-1:0];
                end
            end
        end
        else begin
            // comb
            if (comb_enable) begin
                for (i=0; i<STAGES; i++) begin
                    for (j=0; j<DDELAY; j++) begin
                        if (j == 0) begin
                            if (i == 0) begin
                                cdata_reg[0][0] <= idata_reg[STAGES-1];
                            end
                            else begin
                                cdata_reg[0][i] <= sub_node[i-1];
                            end
                        end
                        else begin
                            cdata_reg[j][i] <= cdata_reg[j-1][i];
                        end
                    end
                    if (i == 0) begin
                        sub_node[0] <= idata_reg[STAGES-1] - cdata_reg[DDELAY-1][0];
                    end
                    else begin
                        sub_node[i] <= sub_node[i-1] - cdata_reg[DDELAY-1][i];
                    end
                end
            end
            data_out_valid <= comb_enable;
            data_out <= result[WIDTHR-1:0];
        end
    end

endmodule
