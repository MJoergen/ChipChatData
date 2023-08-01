module LFSR (
  input wire clk,
  input wire reset_n,
  output wire [7:0] data
);

  reg [7:0] state;
  wire feedback;

  always @(posedge clk or negedge reset_n) begin
    if (~reset_n) begin
      state <= 8'b10001010;
    end else begin
      state <= {state[6:0], feedback};
    end
  end

  assign feedback = state[1] ^ state[4] ^ state[6] ^ state[7];
  assign data = state;

endmodule

