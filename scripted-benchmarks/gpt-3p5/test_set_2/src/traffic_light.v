module TrafficLight (
  input wire clk,
  input wire reset_n,
  input wire enable,
  output reg red,
  output reg yellow,
  output reg green
);

  // State definition
  localparam S_RED = 3'b001;
  localparam S_GREEN = 3'b010;
  localparam S_YELLOW = 3'b100;

  reg [2:0] state, next_state;
  reg [4:0] counter;

  // State register
  always @(posedge clk or negedge reset_n) begin
    if (~reset_n)
      state <= S_RED;
    else
      state <= next_state;
  end

  // Next-state logic
  always @(state, counter, enable) begin
    case (state)
      S_RED:
        if (enable && (counter == 5))
          next_state = S_GREEN;
        else
          next_state = S_RED;
      S_GREEN:
        if (enable && (counter == 31))
          next_state = S_YELLOW;
        else
          next_state = S_GREEN;
      S_YELLOW:
        if (enable && (counter == 7))
          next_state = S_RED;
        else
          next_state = S_YELLOW;
      default:
        next_state = S_RED;
    endcase
  end

  // Counter and output logic
  always @(posedge clk or negedge reset_n) begin
    if (~reset_n) begin
      counter <= 0;
      red <= 1'b1;
      yellow <= 1'b0;
      green <= 1'b0;
    end
    else if (state != next_state) begin
      counter <= counter + 1;
      red <= red;
      yellow <= yellow;
      green <= green;
    end
    else if (enable && (counter == 5) && (state == S_RED)) begin
      counter <= 0;
      red <= 1'b0;
      yellow <= 1'b0;
      green <= 1'b1;
    end
    else if (enable && (counter == 31) && (state == S_GREEN)) begin
      counter <= 0;
      red <= 1'b0;
      yellow <= 1'b1;
      green <= 1'b0;
    end
    else if (enable && (counter == 7) && (state == S_YELLOW)) begin
      counter <= 0;
      red <= 1'b1;
      yellow <= 1'b0;
      green <= 1'b0;
    end
    else begin
      counter <= counter + 1;
      red <= red;
      yellow <= yellow;
      green <= green;
    end
  end

endmodule

