module ShiftRegister (
  input wire clk,
  input wire reset,
  input wire data,
  input wire shift_enable,
  output reg [7:0] output_data
);

  reg [7:0] synchronized_data;
  reg synchronized_shift_enable;
  reg reset_sync;

  always @(posedge clk or negedge reset_sync) begin
    if (!reset_sync) begin
      synchronized_data <= 8'b00000000;  // Reset the synchronized data to all zeroes
      synchronized_shift_enable <= 0;
    end else begin
      synchronized_data <= data;
      synchronized_shift_enable <= shift_enable;
    end
  end

  always @(posedge clk) begin
    if (!reset_sync) begin
      output_data <= 8'b00000000;  // Reset the shift register to all zeroes
    end else if (synchronized_shift_enable) begin
      output_data <= {output_data[6:0], synchronized_data};  // Shift the synchronized data in
    end
  end

  always @(posedge clk or negedge reset) begin
    reset_sync <= ~reset;  // Synchronize the reset signal with the clock
  end

endmodule

