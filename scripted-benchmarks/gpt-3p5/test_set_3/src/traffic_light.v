module TrafficLight (
  input wire clk,
  input wire reset_n,
  input wire enable,
  output wire red,
  output wire yellow,
  output wire green
);

  // Define the states
  parameter RED = 2'b00;
  parameter GREEN = 2'b01;
  parameter YELLOW = 2'b10;

  // Define the state register and next state variables
  reg [1:0] current_state;
  reg [1:0] next_state;

  // Define the counter for each state transition
  reg [5:0] red_to_green_counter;
  reg [5:0] green_to_yellow_counter;
  reg [3:0] yellow_to_red_counter;

  // Output assignments
  assign red = (current_state == RED);
  assign yellow = (current_state == YELLOW);
  assign green = (current_state == GREEN);

  always @(posedge clk or negedge reset_n) begin
    if (~reset_n) begin
      current_state <= RED;
      red_to_green_counter <= 0;
      green_to_yellow_counter <= 0;
      yellow_to_red_counter <= 0;
    end
    else if (enable) begin
      current_state <= next_state;
      case (current_state)
        RED:
          begin
            if (red_to_green_counter == 32)
              next_state = GREEN;
            else
              next_state = RED;

            red_to_green_counter <= red_to_green_counter + 1;
          end
        GREEN:
          begin
            if (green_to_yellow_counter == 20)
              next_state = YELLOW;
            else
              next_state = GREEN;

            green_to_yellow_counter <= green_to_yellow_counter + 1;
          end
        YELLOW:
          begin
            if (yellow_to_red_counter == 7)
              next_state = RED;
            else
              next_state = YELLOW;

            yellow_to_red_counter <= yellow_to_red_counter + 1;
          end
      endcase
    end
  end

endmodule

