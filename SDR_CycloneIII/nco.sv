module nco # (
            parameter                   WIDTH = 16,
            parameter                   WIDTHA = 64, // width accumulator
            parameter                   WIDTHS = 16, // width sine/cosine output
            parameter                   WIDTHT = 11, // with of table (4 * RAM depth),
            parameter                   FILE = ""
)
(
    input   logic                       clock,
    input   logic                       clock_sreset,
    input   logic [WIDTHA-1:0]          phase_increment,
    output  logic signed [WIDTH-1:0]    sine_out,
    output  logic signed [WIDTH-1:0]    cosine_out
);

            logic [WIDTHA-1:0]          phase_accumulator;
            logic [WIDTHS-1:0]          sine, cosine;

    always_ff @ (posedge clock) begin
        if (clock_sreset) begin 
            phase_accumulator <= {WIDTH{1'b0}};
        end
        else begin
            phase_accumulator <= phase_accumulator + phase_increment;
        end
    end
            
    sine_cosine                         # (
                                            .WIDTH(WIDTHS),
                                            .WIDTHT(WIDTHT),
                                            .FILE(FILE)
                                        )
                                        lut (
                                            .clock(clock),
                                            .clock_sreset(clock_sreset),
                                            .theta(phase_accumulator[WIDTHA-1:WIDTHA-WIDTHT]),
                                            .sine_out(sine),
                                            .cosine_out(cosine)
                                        );
                                        
    assign sine_out = sine[WIDTHS-1:WIDTHS-WIDTH];
    assign cosine_out = cosine[WIDTHS-1:WIDTHS-WIDTH];

endmodule
