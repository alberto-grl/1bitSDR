module sdr (
    input   logic                       clock_in1,    // 50.000 MHz
    input   logic                       clock_in2,    // 50.000 Mhz
    
    input   logic                       lvds_in,
    output  logic                       integrator_out,
    
    output  logic [1:0]                 audio_out,
    
    inout   wire                        ps2_kbdat,
    inout   wire                        ps2_kbclk,
    
    output  logic                       sdram_clock,
    output  logic [11:0]                sdram_addr,
    output  logic [1:0]                 sdram_ba,
    output  logic                       sdram_cas_n,
    output  logic                       sdram_cke,
    output  logic                       sdram_cs_n,
    inout   logic [15:0]                sdram_dq,
    output  logic [1:0]                 sdram_dqm,
    output  logic                       sdram_ras_n,
    output  logic                       sdram_we_n
);
            localparam                  SYSTEM_CLOCK = 100000000;
            localparam                  CIC_DECIMATION = 4096;
            localparam                  CIC_STAGES = 5;
            localparam                  PWM_WIDTH = 8;
            localparam                  WIDTH = 16;
            
            logic                       clock_osc;
            logic                       pll0_areset, pll0_locked;
            logic                       pll1_areset, pll1_locked;
            logic                       system_clock, system_clock_sreset;
            
            logic signed [WIDTH-1:0]    rf_data_out;
            logic [3:0]                 cic_gain;
            logic [31:0]                phase_increment;
            logic                       audio, demod_valid;
            
            logic                       demodulated_valid;
            logic [WIDTH-1:0]           demodulated_out;
            
    assign audio_out = {1'b0, audio};
                
    ////////////////////////////////////////////////////////////////////////////////////////
    
    oscillator                  osc (
                                    .oscena(1'b1),
                                    .clkout(clock_osc)
                                );

    pll0                        pll0 (
                                    .inclk0(clock_in2),
                                    .areset(pll0_areset),
                                    .locked(pll0_locked),
                                    .c0(sdram_clock),  // 120.000
                                    .c1(system_clock)  // 120.000 @ -60deg
                                );
                                
    system_monitor              # (
                                    .CLOCKS(1)
                                )
                                monitor0 (
                                    .clock(clock_osc),
                                    .pll_clocks({system_clock}),
                                    .pll_locked(pll0_locked),
                                    .pll_areset(pll0_areset),
                                    .pll_sreset({system_clock_sreset})
                                );

    ////////////////////////////////////////////////////////////////////////////////////////
    
    qsys_block                  qsys (
                                    .system_clock_clk(system_clock),
                                    .system_clock_sreset_reset_n(~system_clock_sreset),
                                    
                                    .sdram_addr(sdram_addr),
                                    .sdram_ba(sdram_ba),
                                    .sdram_cas_n(sdram_cas_n),
                                    .sdram_cke(sdram_cke),
                                    .sdram_cs_n(sdram_cs_n),
                                    .sdram_dq(sdram_dq),
                                    .sdram_dqm(sdram_dqm),
                                    .sdram_ras_n(sdram_ras_n),
                                    .sdram_we_n(sdram_we_n),
                                    
                                    .cic_gain_export(cic_gain),
                                    .phase_increment_export(phase_increment),
                                    
                                    .ps2_clk(ps2_kbclk),
                                    .ps2_dat(ps2_kbdat)
                                    
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
                                    .phase_increment(phase_increment),
                                    .cic_gain(cic_gain),
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
