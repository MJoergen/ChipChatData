module BinaryToBCD_tb;

  reg [4:0] binary_input;
  wire [7:0] bcd_output;

  BinaryToBCD dut (
    .binary_input(binary_input),
    .bcd_output(bcd_output)
  );

  integer num_tests;
  reg [7:0] expected_output;

  initial begin
    num_tests = 0;

    // Test case 1: Binary 0
    binary_input = 5'b00000;
    expected_output = 8'b0000_0000;
    #10;
    num_tests = num_tests + 1;
    check_output();

    // Test case 2: Binary 3
    binary_input = 5'b00011;
    expected_output = 8'b0000_0011;
    #10;
    num_tests = num_tests + 1;
    check_output();

    // Add more test cases here...

    $display("All test cases passed! Total tests: %d", num_tests);
    $finish;
  end

  // Check the output against the expected output
  task check_output;
  begin
    if (bcd_output !== expected_output) begin
      $display("Test case %d failed!", num_tests);
      $display("Input: %b, Expected BCD Output: %b, Actual BCD Output: %b",
               binary_input, expected_output, bcd_output);
    end
  end
  endtask

endmodule

