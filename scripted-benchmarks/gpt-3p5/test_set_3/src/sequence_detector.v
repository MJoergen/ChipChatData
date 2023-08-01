module SequenceDetector(
  input wire clk,
  input wire rst_n,
  input wire [2:0] data,
  output reg sequence_found
);

  reg [2:0] state;
  reg [2:0] next_state;
  reg [2:0] prev_data;

  // Define the sequence pattern
  localparam [7:0] SEQUENCE_PATTERN = 8'b0011011000110101;

  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      // Reset the state and other variables
      state <= 3'b000;
      prev_data <= 3'b000;
      sequence_found <= 1'b0;
    end else begin
      // State transitions
      state <= next_state;
      prev_data <= data;

      case (state)
        3'b000: begin // Initial state
          if (data == 3'b001)
            next_state = 3'b001;
          else
            next_state = 3'b000;
        end

        3'b001: begin
          if (data == 3'b101)
            next_state = 3'b010;
          else
            next_state = 3'b000;
        end

        3'b010: begin
          if (data == 3'b110)
            next_state = 3'b011;
          else
            next_state = 3'b000;
        end

        3'b011: begin
          if (data == 3'b000)
            next_state = 3'b100;
          else
            next_state = 3'b000;
        end

        3'b100: begin
          if (data == 3'b110)
            next_state = 3'b101;
          else
            next_state = 3'b000;
        end

        3'b101: begin
          if (data == 3'b110)
            next_state = 3'b110;
          else
            next_state = 3'b000;
        end

        3'b110: begin
          if (data == 3'b011)
            next_state = 3'b111;
          else
            next_state = 3'b000;
        end

        3'b111: begin
          if (data == 3'b101)
            next_state = 3'b000;
          else
            next_state = 3'b000;
        end
      endcase
    end
  end

  always @(posedge clk or negedge rst_n) begin
    if (~rst_n)
      sequence_found <= 1'b0;
    else if (state == 3'b111 && prev_data == SEQUENCE_PATTERN[7:5])
      sequence_found <= 1'b1;
  end

endmodule

