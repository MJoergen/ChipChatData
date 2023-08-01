module LFSR_Testbench;

  reg clk;
  reg reset_n;
  wire [7:0] data;

  initial begin
    // Initialize inputs
    clk = 0;
    reset_n = 0;

    // Generate clock
    forever #5 clk = ~clk;
  end

  always @(posedge clk) begin
    if ($time == 0) begin
      // Release reset after 1 clock cycle
      reset_n <= 1;
    end else if ($time == 15) begin
      // Stop simulation after 15 clock cycles
      $finish;
    end
  end

  // Instantiate LFSR module
  LFSR LFSR_inst (
    .clk(clk),
    .reset_n(reset_n),
    .data(data)
  );

  // Expected output values
  reg [7:0] expected_data;
  reg initial_state_checked;
  initial begin
    expected_data = 8'b10001010;
    initial_state_checked = 0;

    // Wait for the first clock edge
    @(posedge clk);

    // Check initial state
    if (data !== expected_data) begin
      $display("Error: Initial state mismatch");
      $finish(1);
    end

    initial_state_checked = 1;
  end

  // Check data output
  always @(posedge clk) begin
    if (initial_state_checked && reset_n) begin
      // Compare output data with expected value
      if (data !== expected_data) begin
        $display("Error at time %t: Expected: %b, Got: %b", $time, expected_data, data);
        $finish(1);
      end

      // Generate expected data for the next clock cycle
      expected_data = {expected_data[6:0], expected_data[1] ^ expected_data[4] ^ expected_data[6] ^ expected_data[7]};
    end
  end

endmodule

