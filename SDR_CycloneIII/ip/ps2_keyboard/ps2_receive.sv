module ps2_receive # (
            parameter           SYSTEM_CLOCK = 50000000
)
(
    input   logic               clock,
    input   logic               clock_sreset,
    
    inout   logic               ps2_clk,
    inout   logic               ps2_dat,
    
    output  logic               data_valid,
    output  logic [10:0]        data_out
);

            localparam          ONE = 128'h1;
            localparam          ZERO = 128'h0;
            localparam          DONTCARE = {128{1'bx}};

    enum    logic [7:0]         {S1, S2, S3, S4, S5, S6, S7, S8} fsm;
            logic [3:0]         counter;
            logic               ps2_clk_valid_out, ps2_clk_out;
            logic               ps2_dat_valid_out, ps2_dat_out;
            
    debounce                    # (
                                    .SYSTEM_CLOCK(SYSTEM_CLOCK),
                                    .DELAY_US(5),
                                    .WIDTHM(3)
                                )
                                clk (
                                    .clock(clock),
                                    .clock_sreset(clock_sreset),
                                    .in(ps2_clk),
                                    .valid_out(ps2_clk_valid_out),
                                    .out(ps2_clk_out)
                                );
                                
    debounce                    # (
                                    .SYSTEM_CLOCK(SYSTEM_CLOCK),
                                    .DELAY_US(5),
                                    .WIDTHM(3)
                                )
                                dat (
                                    .clock(clock),
                                    .clock_sreset(clock_sreset),
                                    .in(ps2_dat),
                                    .valid_out(ps2_dat_valid_out),
                                    .out(ps2_dat_out)
                                );
                                
    always_ff @ (posedge clock) begin
        if (clock_sreset) begin
            counter <= 4'h0;
            data_out <= DONTCARE[10:0];
            data_valid <= 1'b0;
        end
        else begin
            if (ps2_clk_valid_out & ps2_dat_valid_out) begin
                case (fsm)
                    S1 : begin
                        counter <= 4'h0;
                        data_valid <= 1'b0;
                        if (~ps2_clk_out & ~ps2_dat_out) begin  // start bit
                            fsm <= S2;
                        end
                    end
                    S2 : begin
                        if (ps2_clk_out) begin
                            data_out <= {ps2_dat_out, data_out[10:1]};
                            counter <= counter + 4'h1;
                            if (counter >= 4'ha) begin
                                fsm <= S4;
                            end
                            else begin
                                fsm <= S3;
                            end
                        end
                    end
                    S3 : begin
                        if (~ps2_clk_out) begin
                            fsm <= S2;
                        end
                    end
                    S4 : begin
                        data_valid <= 1'b1;//(~^data_out[8:1]) == data_out[9];
                        fsm <= S1;
                    end
                endcase
            end
            else begin
                data_valid <= 1'b0;
            end
        end
    end

endmodule
