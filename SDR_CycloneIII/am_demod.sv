module am_demod # (
            parameter                   WIDTH = 16
)
(
    input   wire                        clock,
    input   logic                       clock_sreset,
    input   logic                       in_valid,
    input   logic signed [WIDTH-1:0]    i_in,
    input   logic signed [WIDTH-1:0]    q_in,
    output  logic                       demod_valid,
    output  logic signed [WIDTH-1:0]    demod
);
            localparam                  ZERO = 128'h0;
            localparam                  DONTCARE = {128{1'bx}};
            localparam                  WIDTHD = WIDTH * 2;
            localparam                  WIDTHH = (WIDTH / 2);
            logic signed [WIDTHD-1:0]   i_squared, q_squared;
            logic [WIDTHD:0]            sum;
            logic [WIDTH:0]             sqrt_result;
            logic [8:0]                 demod_valid_pipe;

	altsqrt	    # (
                    .pipeline(8),
                    .width(WIDTHD+1),
                    .q_port_width(WIDTH),
                    .r_port_width(WIDTH+1)
                )
                sqrt(
                    .clk (clock),
                    .ena(1'b1),
                    .radical(sum),
                    .q(sqrt_result),
                    .remainder(),
                    .aclr(1'b0)
                );
                
	lpm_mult	# (
                    .lpm_pipeline(2),
                    .lpm_widtha(WIDTH),
                    .lpm_widthb(WIDTH),
                    .lpm_widths(1),
                    .lpm_representation("SIGNED"),
                    .lpm_widthp(WIDTHD)
                )
                i_square (
                    .clock(clock),
                    .aclr(1'b0),
                    .clken(1'b1),
                    .dataa(i_in),
                    .datab(i_in),
                    .sum(1'b0),
                    .result(i_squared)
                );

	lpm_mult	# (
                    .lpm_pipeline(2),
                    .lpm_widtha(WIDTH),
                    .lpm_widthb(WIDTH),
                    .lpm_widths(1),
                    .lpm_representation("SIGNED"),
                    .lpm_widthp(WIDTHD)
                )
                q_square (
                    .clock(clock),
                    .aclr(1'b0),
                    .clken(1'b1),
                    .dataa(q_in),
                    .datab(q_in),
                    .sum(1'b0),
                    .result(q_squared)
                );

                
    assign demod = sqrt_result[WIDTH-1:0];
    
    always_ff @ (posedge clock) begin
        if (clock_sreset) begin
            sum <= DONTCARE[WIDTHD:0];
        end
        else begin
            sum <= {1'b0, i_squared} + {1'b0, q_squared};
            {demod_valid, demod_valid_pipe} <= {demod_valid_pipe, in_valid};
        end
    end

endmodule
