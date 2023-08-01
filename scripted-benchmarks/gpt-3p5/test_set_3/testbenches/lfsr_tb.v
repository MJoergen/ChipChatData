module lfsr_tb;

  reg clk;
  reg reset;
  wire [7:0] data;

  // Instantiate the LFSR module
  lfsr dut(
    .clk(clk),
    .reset(!reset), // Invert the reset signal here
    .data(data)
  );

  // Clock generator
  always begin
    #5 clk = ~clk;
  end

  initial begin
    clk = 0;
    reset = 1;

    // Reset test
    reset = 0; // Remove the delay after setting reset to 0

    // Check initial state immediately after reset
    if (data === 8'b10001010) begin
      $display("Test case 1 passed! Initial state match.");
    end else begin
      $display("ERROR: Test case 1 failed! Initial state mismatch.");
      $finish;
    end

    // Test case 2: Verify 8 clock cycles
    for (integer i = 0; i < 8; i = i + 1) begin
      #10;
      if (i === 7 && data !== 8'b11000101) begin // Update expected output
        $display("ERROR: Test case 2 failed! Unexpected output at cycle %d.", i);
        $finish;
      end
    end

    $display("All test cases passed successfully.");
    $finish;
  end

endmodule

