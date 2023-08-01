module SequenceGenerator(
  input wire clk,
  input wire reset_n,
  input wire enable,
  output reg [7:0] data
);

  // Define states for the FSM
  typedef enum logic [2:0] {
    STATE_IDLE,
    STATE_OUTPUT1,
    STATE_OUTPUT2,
    STATE_OUTPUT3,
    STATE_OUTPUT4,
    STATE_OUTPUT5,
    STATE_OUTPUT6,
    STATE_OUTPUT7,
    STATE_OUTPUT8
  } state_type;

  // Define current state and next state variables
  reg [2:0] current_state, next_state;

  // Define sequence values
  reg [7:0] sequence [8:1] = '{8'hAF, 8'hBC, 8'hE2, 8'h78, 8'hFF, 8'hE2, 8'h0B, 8'h8D};

  always @(posedge clk or negedge reset_n) begin
    if (~reset_n) begin
      // Reset to initial state and output the first value
      current_state <= STATE_OUTPUT1;
      data <= sequence[1];
    end
    else if (enable) begin
      // Update the state and output the corresponding sequence value
      current_state <= next_state;
      data <= sequence[current_state];
    end
  end

  // Define the next state logic
  always @(current_state or enable) begin
    case (current_state)
      STATE_IDLE:
        if (enable) next_state <= STATE_OUTPUT1;
        else next_state <= STATE_IDLE;
      STATE_OUTPUT1: next_state <= STATE_OUTPUT2;
      STATE_OUTPUT2: next_state <= STATE_OUTPUT3;
      STATE_OUTPUT3: next_state <= STATE_OUTPUT4;
      STATE_OUTPUT4: next_state <= STATE_OUTPUT5;
      STATE_OUTPUT5: next_state <= STATE_OUTPUT6;
      STATE_OUTPUT6: next_state <= STATE_OUTPUT7;
      STATE_OUTPUT7: next_state <= STATE_OUTPUT8;
      STATE_OUTPUT8: next_state <= STATE_OUTPUT1;
      default: next_state <= STATE_IDLE;
    endcase
  end

endmodule

