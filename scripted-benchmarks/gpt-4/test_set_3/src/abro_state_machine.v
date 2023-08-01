module abro_fsm (
    input wire clk,
    input wire reset_n,
    input wire A,
    input wire B,
    output wire O,
    output wire [3:0] State
);

    // One-hot encoded state definitions
    localparam S0 = 4'b0001;
    localparam S1 = 4'b0010;
    localparam S2 = 4'b0100;
    localparam S3 = 4'b1000;

    // Flip-flop for the current state
    reg [3:0] current_state;
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            current_state <= S0;
        end else begin
            case (current_state)
                S0: current_state <= A ? S1 : S0;
                S1: current_state <= B ? S2 : S0;
                S2: current_state <= A ? S3 : S0;
                S3: current_state <= B ? S1 : S0;
                default: current_state <= S0;
            endcase
        end
    end

    // Output logic and state assignment
    assign O = current_state == S2;
    assign State = current_state;

endmodule

