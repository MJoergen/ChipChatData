module ABRO_StateMachine (
  input clk,
  input resetn,
  input A,
  input B,
  output reg O,
  output reg [3:0] state
);
  // Internal signals
  reg [3:0] next_state;

  // State machine definition
  always @(posedge clk or negedge resetn)
  begin
    if (!resetn)
      state <= 4'b0000;
    else
      state <= next_state;
  end

  // Next state logic
  always @(*)
  begin
    case (state)
      4'b0000: next_state = A ? 4'b0001 : 4'b0000;
      4'b0001: next_state = B ? 4'b0010 : 4'b0011;
      4'b0010: next_state = A ? 4'b0001 : 4'b0010;
      4'b0011: next_state = B ? 4'b0100 : 4'b0011;
      4'b0100: next_state = A ? 4'b0101 : 4'b0100;
      4'b0101: next_state = B ? 4'b0110 : 4'b0101;
      4'b0110: next_state = A ? 4'b0001 : 4'b0110;
      default: next_state = 4'b0000;
    endcase
  end

  // Output logic
  always @(posedge clk)
  begin
    case (next_state)
      4'b0001: O <= 1'b0;
      default: O <= 1'b1;
    endcase
  end
endmodule

