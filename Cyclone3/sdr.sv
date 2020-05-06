module sdr (
    input   logic                       clock_in1,    // 50.000 MHz
    input   logic                       lvds_in,
    output  logic                       integrator_out,
    
    output  logic [1:0]                 audio_out
    
);
            localparam                  CIC_DECIMATION = 8192;
            localparam                  CIC_STAGES = 5;
            localparam                  PWM_WIDTH = 8;
            localparam                  WIDTH = 16;

            logic                       osc_clock;
            logic                       pll0_areset, pll0_locked;
            logic                       system_clock, system_clock_sreset;
            
            logic signed [WIDTH-1:0]    rf_data_out;
            logic                       audio, demod_valid;
            
            logic                       demodulated_valid;
            logic [WIDTH-1:0]           demodulated_out;
            
    assign audio_out = {1'b0, audio};
    
    ////////////////////////////////////////////////////////////////////////////////////////
    
    oscillator                  osc (
                                    .oscena(1'b1),
                                    .clkout(osc_clock)
                                );

    pll0                        pll0 (
                                    .inclk0(clock_in1),
                                    .areset(pll0_areset),
                                    .locked(pll0_locked),
                                    .c0(system_clock)  // 80.000
                                );
                                
    system_monitor              # (
                                    .CLOCKS(1)
                                )
                                monitor0 (
                                    .clock(osc_clock),
                                    .pll_clocks({system_clock}),
                                    .pll_locked(pll0_locked),
                                    .pll_areset(pll0_areset),
                                    .pll_sreset({system_clock_sreset})
                                );

    ////////////////////////////////////////////////////////////////////////////////////////
    
    
    lvds_rf_input               rf_in (
                                    .clock(system_clock),
                                    .clock_sreset(system_clock_sreset),
                                    .lvds_in(lvds_in),
                                    .integrator_out(integrator_out),
                                    .data_out(rf_data_out)
                                );
    
    am_receiver                 # (
                                    .WIDTH(WIDTH),
                                    .CIC_DECIMATION(CIC_DECIMATION),
                                    .CIC_STAGES(CIC_STAGES)
                                )
                                am_receiver (
                                    .clock(system_clock),
                                    .clock_sreset(system_clock_sreset),
                                    .phase_increment(32'h126E978),
                                    .cic_gain(4'h9),
                                    .data_in(rf_data_out),
                                    .demodulated_valid(demodulated_valid),
                                    .demodulated_out(demodulated_out)
                                );
                                
    pwm                         # (
                                    .WIDTH(PWM_WIDTH)
                                )
                                pwm (
                                    .clock(system_clock),
                                    .clock_sreset(system_clock_sreset),
                                    .data_valid(demodulated_valid),
                                    .data($signed(demodulated_out[WIDTH-1:WIDTH-PWM_WIDTH] - (1 << (PWM_WIDTH-1)))),
                                    .pwm_out(audio)
                                );

endmodule
