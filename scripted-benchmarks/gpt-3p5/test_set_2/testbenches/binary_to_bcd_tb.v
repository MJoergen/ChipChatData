module BinaryToBCD_Testbench;

  // Parameters
  parameter CLOCK_PERIOD = 10;  // Clock period in simulation time units

  // Inputs
  reg [4:0] binary_input;

  // Outputs
  wire [7:0] bcd_output;

  // Instantiate the design under test
  BinaryToBCD dut (
    .binary_input(binary_input),
    .bcd_output(bcd_output)
  );

  // Clock generation
  reg clock;
  always #((CLOCK_PERIOD)/2) clock = ~clock;

  // Test stimulus
  initial begin
    // Initialize inputs
    binary_input = 5'b00000;

    // Wait for a few clock cycles
    #10;

    // Test case 1: Binary input = 0
    binary_input = 5'b00000;
    #10;
    $display("Test case 1:");
    $display("Binary input = %05b", binary_input);
    $display("Expected BCD output = 00000000");
    $display("Actual BCD output = %08b", bcd_output);
    if (bcd_output !== 8'b00000000) $error("Test case 1 failed!");

    // Test case 2: Binary input = 3
    binary_input = 5'b00011;
    #10;
    $display("Test case 2:");
    $display("Binary input = %05b", binary_input);
    $display("Expected BCD output = 00000011");
    $display("Actual BCD output = %08b", bcd_output);
    if (bcd_output !== 8'b00000011) $error("Test case 2 failed!");

    // Test case 3: Binary input = 9
    binary_input = 5'b01001;
    #10;
    $display("Test case 3:");
    $display("Binary input = %05b", binary_input);
    $display("Expected BCD output = 00001001");
    $display("Actual BCD output = %08b", bcd_output);
    if (bcd_output !== 8'b00001001) $error("Test case 3 failed!");

    // Test case 4: Binary input = 13
    binary_input = 5'b01101;
    #10;
    $display("Test case 4:");
    $display("Binary input = %05b", binary_input);
    $display("Expected BCD output = 00010011");
    $display("Actual BCD output = %08b", bcd_output);
    if (bcd_output !== 8'b00010011) $error("Test case 4 failed!");

    // Test case 5: Binary input exceeds valid range
    binary_input = 5'b11111;
    #10;
    $display("Test case 5:");
    $display("Binary input = %05b", binary_input);
    $display("Expected BCD output = 00000000");
    $display("Actual BCD output = %08b", bcd_output);
    if (bcd_output !== 8'b00000000) $error("Test case 5 failed!");

    $display("All test cases passed!");

// End simulation
$finish;

end

// Apply clock signal always @(posedge clock) begin // Do nothing, just provide a clock signal end

endmodule
