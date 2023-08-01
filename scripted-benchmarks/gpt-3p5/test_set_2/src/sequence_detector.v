module SequenceDetector(
  input wire clk,
  input wire reset_n,
  input wire [2:0] data,
  output reg sequence_found
);

  // Define states using parameters
  parameter S_IDLE = 4'b0000;
  parameter S_001 = 4'b0001;
  parameter S_101 = 4'b0010;
  parameter S_110 = 4'b0011;
  parameter S_000 = 4'b0100;
  parameter S_110_1 = 4'b0101;
  parameter S_110_2 = 4'b0110;
  parameter S_011 = 4'b0111;
  parameter S_101_1 = 4'b1000;

  // Define internal signals
  reg [3:0] current_state;
  reg [3:0] next_state;

  // Sequential logic for state transition
  always @(posedge clk or negedge reset_n) begin
    if (!reset_n)
      current_state <= S_IDLE;
    else
      current_state <= next_state;
  end

  // Combinational logic for next state and sequence detection
  always @(*) begin
    next_state = current_state;
    sequence_found = 0;

    case (current_state)
      S_IDLE: begin
        if (data == 3'b001)
          next_state = S_001;
      end

      S_001: begin
        if (data == 3'b101)
          next_state = S_101;
        else
          next_state = S_IDLE;
      end

      S_101: begin
        if (data == 3'b110)
          next_state = S_110;
        else
          next_state = S_IDLE;
      end

      S_110: begin
        if (data == 3'b000)
          next_state = S_000;
        else
          next_state = S_IDLE;
      end

      S_000: begin
        if (data == 3'b110)
          next_state = S_110_1;
        else
          next_state = S_IDLE;
      end

      S_110_1: begin
        if (data == 3'b110)
          next_state = S_110_2;
        else
          next_state = S_IDLE;
      end

      S_110_2: begin
        if (data == 3'b011) begin
          next_state = S_011;
          sequence_found = 1;
        end
        else
          next_state = S_IDLE;
      end

      S_011: begin
        if (data == 3'b101)
          next_state = S_101_1;
        else
          next_state = S_IDLE;
      end

      S_101_1: begin
        next_state = S_IDLE;
      end
    endcase
  end

endmodule

