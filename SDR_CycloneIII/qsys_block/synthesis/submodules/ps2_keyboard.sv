module ps2_keyboard # (
            parameter           SYSTEM_CLOCK = 50000000
)
(
    input   logic               clock,
    input   logic               clock_sreset,
    
    input   wire                ps2_clk,
    input   wire                ps2_dat,
    
    input   logic [3:0]         s_address,
    input   logic [31:0]        s_writedata,
    output  logic [31:0]        s_readdata,
    input   logic               s_read,
    input   logic               s_write,
    output  logic               s_waitrequest,
    output  logic               irq
);
            logic [10:0]        ps2_data;
            logic               ps2_data_valid;
            logic               irq_flag, event_flag, read_latency;
            logic [7:0]         data_reg;

    ps2_receive                 # (
                                    .SYSTEM_CLOCK(SYSTEM_CLOCK)
                                )
                                ps2_rx (
                                    .clock(clock),
                                    .clock_sreset(clock_sreset),
                                    .ps2_clk(ps2_clk),
                                    .ps2_dat(ps2_dat),
                                    .data_valid(ps2_data_valid),
                                    .data_out(ps2_data)
                                );
                                
    always_comb begin
        s_waitrequest = s_write ? 1'b0 : (s_read ? ~read_latency : s_read);
    end
    always_ff @ (posedge clock) begin
        if (clock_sreset) begin
            read_latency <= 1'b0;
            event_flag <= 1'b0;
            irq_flag <= 1'b0;
        end
        else begin
            read_latency <= read_latency ? 1'b0 : s_read;
            if (ps2_data_valid) begin
                data_reg <= ps2_data[8:1];
                event_flag <= 1'b1;
            end
            if (s_address == 4'h0) begin
                s_readdata <= {event_flag, irq_flag};
                if (s_write) begin
                    irq_flag <= s_writedata[0];
                end
            end
            if (s_address == 4'h1) begin
                if (s_write) begin
                    irq <= 1'b0;
                end
                else begin
                    irq <= irq_flag & ps2_data_valid;
                end
            end
            else begin
                irq <= irq_flag & ps2_data_valid;
            end
            if (s_address == 4'h2) begin
                s_readdata <= data_reg;
                if (s_write) begin
                    event_flag <= 1'b0;
                end
            end
        end
    end

endmodule
