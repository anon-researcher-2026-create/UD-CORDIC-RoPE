module cordic_standard_core #(
    parameter W = 11,
    parameter STAGES = 14
)(
    input  clk,
    input  rst,

    input  signed [W-1:0] x_in,
    input  signed [W-1:0] y_in,
    input  signed [W-1:0] z_in,

    output signed [W-1:0] x_out,
    output signed [W-1:0] y_out
);

    // =========================================================
    // DYNAMIC LUT: Base values are Q1.14. 
    // We shift them down dynamically based on the actual W.
    // Assuming format is Q2.(W-2) -> fractional bits = W - 2.
    // Shift amount = 14 - (W - 2) = 16 - W
    // =========================================================
    function signed [W-1:0] get_atan;
        input integer idx;
        integer base_val;
        begin
            case (idx)
                0: base_val = 6434; // atan(2^-0) in Q1.14
                1: base_val = 3798;
                2: base_val = 2007;
                3: base_val = 1019;
                4: base_val = 511;
                5: base_val = 256;
                6: base_val = 128;
                7: base_val = 64;
                8: base_val = 32;
                9: base_val = 16;
                default: base_val = 0;
            endcase
            // Shift down if W < 16, Shift up if W > 16
            if (16 > W)
                get_atan = base_val >>> (16 - W);
            else
                get_atan = base_val <<< (W - 16);
        end
    endfunction

    // Pipeline wire arrays
    wire signed [W-1:0] x_pipe [0:STAGES];
    wire signed [W-1:0] y_pipe [0:STAGES];
    wire signed [W-1:0] z_pipe [0:STAGES];

    // Pipeline register arrays for sequential logic
    reg signed [W-1:0] x_reg [0:STAGES];
    reg signed [W-1:0] y_reg [0:STAGES];
    reg signed [W-1:0] z_reg [0:STAGES];

    assign x_pipe[0] = x_in;
    assign y_pipe[0] = y_in;
    assign z_pipe[0] = z_in;

    genvar i;
    generate
        for (i = 0; i < STAGES; i = i + 1) begin : STAGE
            
            // Wire the output of the stage
            wire signed [W-1:0] x_stage_out;
            wire signed [W-1:0] y_stage_out;
            wire signed [W-1:0] z_stage_out;

            // Instantiate the unused stage module properly!
            cordic_standard_stage #(
                .W(W),
                .I(i),
                .ATAN(get_atan(i)) // Dynamically scaled ATAN
            ) stage_inst (
                .x_in(x_pipe[i]),
                .y_in(y_pipe[i]),
                .z_in(z_pipe[i]),
                .x_out(x_stage_out),
                .y_out(y_stage_out),
                .z_out(z_stage_out)
            );

            // Register the outputs for a clean pipeline
            always @(posedge clk) begin
                if (rst) begin
                    x_reg[i+1] <= 0;
                    y_reg[i+1] <= 0;
                    z_reg[i+1] <= 0;
                end else begin
                    x_reg[i+1] <= x_stage_out;
                    y_reg[i+1] <= y_stage_out;
                    z_reg[i+1] <= z_stage_out;
                end
            end
            
            // Connect registers to the next pipe stage
            assign x_pipe[i+1] = x_reg[i+1];
            assign y_pipe[i+1] = y_reg[i+1];
            assign z_pipe[i+1] = z_reg[i+1];
            
        end
    endgenerate

    assign x_out = x_pipe[STAGES];
    assign y_out = y_pipe[STAGES];

endmodule
