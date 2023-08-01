module abro_state_machine (
    input wire clk,
    input wire reset_n, // Active-low reset
    input wire A,
    input wire B,
    output wire O,
    output reg [3:0] state // 4-bit state for one-hot encoding
);

// One-hot encoded states
localparam IDLE = 4'b0001,
           STATE_A = 4'b0010,
           STATE_B = 4'b0100,
           STATE_O = 4'b1000;

// State transition logic
always @(posedge clk or negedge reset_n) begin
    if (~reset_n) begin
        state <= IDLE;
    end else begin
        case (state)
            IDLE: begin
                if (A) state <= STATE_A;
                else if (B) state <= STATE_B;
            end
            STATE_A: begin
                if (B) state <= STATE_B;
                else state <= IDLE;
            end
            STATE_B: begin
                if (A) state <= STATE_O;
                else state <= IDLE;
            end
            STATE_O: begin
                state <= IDLE;
            end
        endcase
    end
end

// Output logic
assign O = (state == STATE_O);

endmodule

