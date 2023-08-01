module lfsr(
  input wire clk,
  input wire reset,
  output wire [7:0] data
);

  reg [7:0] state;
  reg feedback;

  always @(posedge clk or negedge reset) begin
    if (!reset) begin
      state <= 8'b10001010; // Initial state
    end else begin
      feedback <= state[1] ^ state[4] ^ state[6] ^ state[7]; // Feedback calculation
      state <= {state[6:0], feedback}; // Shift register
    end
  end

  assign data = state;

endmodule

