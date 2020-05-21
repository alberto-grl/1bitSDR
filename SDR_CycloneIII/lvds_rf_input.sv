/*
    The lvds_in port is an LVDS input that has the + input pin mid-baised to
    1.25V or 1.65V the mid point fed by antenna.  The - input pin is
    driven by an R from integtaor out and a C from - input to GND.
    R typically can be 3k9 C can be 470pF or some 1/(2.pi.R.C) that
    suits.
*/
module lvds_rf_input # (
            parameter                   WIDTH = 16
)
(
    input   logic                       clock,
    input   logic                       clock_sreset,
    input   logic                       lvds_in,
    output  logic                       integrator_out,
    output  logic signed [WIDTH-1:0]    data_out
);
            localparam                  ONE = 128'h1;
            localparam                  ZERO = 128'h0;
            logic [1:0]                 metastable;

    always_ff @ (posedge clock) begin
        integrator_out <= lvds_in;
        metastable <= {metastable[0], integrator_out};
    end
    
    always_ff @ (posedge clock) begin
        if (clock_sreset) begin
            data_out <= {WIDTH{1'b0}};
        end
        else begin
            if (metastable[1]) begin
                data_out <= ~ZERO[WIDTH-1:0];
            end
            else begin
                data_out <= ONE[WIDTH-1:0];
            end
        end
    end

endmodule
