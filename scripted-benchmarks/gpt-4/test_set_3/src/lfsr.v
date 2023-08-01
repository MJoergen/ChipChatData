module lfsr_8bit (
    input wire clk,
    input wire reset_n,
    output wire [7:0] data
);

// Set the initial state
reg [7:0] lfsr_state = 8'b10001010;

// The taps are at locations 1, 4, 6, and 7.
wire tap1 = lfsr_state[1];
wire tap4 = lfsr_state[4];
wire tap6 = lfsr_state[6];
wire tap7 = lfsr_state[7];

// XOR the taps
wire feedback = tap1 ^ tap4 ^ tap6 ^ tap7;

always @(posedge clk or negedge reset_n) begin
    if (~reset_n) begin
        // Active-low reset, set the LFSR state to the initial value
        lfsr_state <= 8'b10001010;
    end else begin
        // Shift right and apply feedback to the most significant bit
        lfsr_state <= {feedback, lfsr_state[7:1]};
    end
end

// Assign the LFSR state to the output data
assign data = lfsr_state;

endmodule

