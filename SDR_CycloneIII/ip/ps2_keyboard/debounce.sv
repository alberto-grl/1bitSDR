module debounce # (
            parameter           SYSTEM_CLOCK = 50000000,
            parameter           DELAY_US = 5,
            parameter           WIDTHM = 3  // metastabilty flops
)
(
    input   logic               clock,
    input   logic               clock_sreset,
    input   logic               in,
    output  logic               out,
    output  logic               valid_out
);
            localparam          ZERO = 128'h0;
            localparam          ONE = 128'h1;
            localparam          CYCLES = ((SYSTEM_CLOCK * DELAY_US) / 1000000);
            localparam          WIDTHC = $clog2(CYCLES);
            
            logic [WIDTHC-1:0]  counter;
            logic [WIDTHM-1:0]  meta_sample;
            logic               in_reg, last_in_reg;
            
    always_ff @ (posedge clock) begin
        meta_sample <= {meta_sample[WIDTHM-2:0], in};
    end
    
    always_ff @ (posedge clock) begin
        if (clock_sreset) begin
            counter <= ZERO[WIDTHC-1:0];
            last_in_reg <= 1'b0;
            in_reg <= 1'b0;
            valid_out <= 1'b0;
            out <= 1'bx;
        end
        else begin
            in_reg <= meta_sample[WIDTHM-1];
            last_in_reg <= in_reg;
            if (last_in_reg == in_reg) begin
                if (counter >= (CYCLES[WIDTHC-1:0] - ONE[WIDTHC-1:0])) begin
                    valid_out <= 1'b1;
                    out <= in_reg;
                end
                else begin
                    valid_out <= 1'b0;
                    counter <= counter + ONE[WIDTHC-1:0];
                end
            end
            else begin
                valid_out <= 1'b0;
                counter <= ZERO[WIDTHC-1:0];
            end
        end
    end

endmodule
