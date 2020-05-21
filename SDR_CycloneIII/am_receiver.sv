module am_receiver # (
            parameter                   WIDTH = 12,
            parameter                   CIC_DECIMATION = 4096,
            parameter                   CIC_STAGES = 5
)
(
    input   logic                       clock,
    input   logic                       clock_sreset,
    input   logic [31:0]                phase_increment,    // tuning input to NCO
    input   logic [3:0]                 cic_gain,
    input   logic signed [WIDTH-1:0]    data_in,
    output  logic                       demodulated_valid,
    output  logic signed [WIDTH-1:0]    demodulated_out
);
            logic signed [WIDTH-1:0]    sine_output, cosine_output;
            logic signed [WIDTH-1:0]    mixer_sine_out, mixer_cosine_out;
            logic signed [WIDTH-1:0]    cic_i_out, cic_q_out;
            logic                       cic_out_ena, clock_sreset_reg;

    // fan out synchronous reset in this module
    always_ff @ (posedge clock) begin
        clock_sreset_reg <= clock_sreset;
    end
            
    nco                                 # (
                                            .WIDTHA(32),
                                            .WIDTHT(11),
                                            .WIDTHS(16),
                                            .WIDTH(WIDTH),
                                            .FILE("quarter_wave_512.hex")
                                        )
                                        nco (
                                            .clock(clock),
                                            .clock_sreset(clock_sreset_reg),
                                            .phase_increment(phase_increment),
                                            .sine_out(sine_output),
                                            .cosine_out(cosine_output)
                                        );
                                
    mixer                               #(
                                            .WIDTH(WIDTH)
                                        )
                                        mixer (
                                            .clock(clock),
                                            .clock_sreset(clock_sreset_reg),
                                            .data_in(data_in),
                                            .sine_in(sine_output),
                                            .cosine_in(cosine_output),
                                            .sine_out(mixer_sine_out),
                                            .cosine_out(mixer_cosine_out)
                                        );
                              
    cic_filter                          # (
                                            .WIDTH(WIDTH),
                                            .STAGES(CIC_STAGES),
                                            .DDELAY(1),
                                            .DECIMATION(CIC_DECIMATION),
                                            .WIDTHR(WIDTH)
                                        )
                                        i_cic (
                                            .clock(clock),
                                            .clock_sreset(clock_sreset_reg),
                                            .gain(cic_gain[3:0]),
                                            .data_in_valid(1'b1),
                                            .data_in(mixer_sine_out),
                                            .data_out_valid(cic_out_ena),
                                            .data_out(cic_i_out)
                                        );

    cic_filter                          # (
                                            .WIDTH(WIDTH),
                                            .STAGES(CIC_STAGES),
                                            .DDELAY(1),
                                            .DECIMATION(CIC_DECIMATION),
                                            .WIDTHR(WIDTH)
                                        )
                                        q_cic (
                                            .clock(clock),
                                            .clock_sreset(clock_sreset_reg),
                                            .gain(cic_gain[3:0]),
                                            .data_in_valid(1'b1),
                                            .data_in(mixer_cosine_out),
                                            .data_out_valid(),
                                            .data_out(cic_q_out)
                                        );
                                
                                
    am_demod                            # (
                                            .WIDTH(WIDTH)
                                        )
                                        demod (
                                            .clock(clock),
                                            .clock_sreset(clock_sreset_reg),
                                            .in_valid(cic_out_ena),
                                            .i_in(cic_i_out),
                                            .q_in(cic_q_out),
                                            .demod_valid(demodulated_valid),
                                            .demod(demodulated_out)
                                        );
    

endmodule
