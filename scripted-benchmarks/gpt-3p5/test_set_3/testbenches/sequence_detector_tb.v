module SequenceDetector_TB;

  // Parameters
  parameter CLK_PERIOD = 10; // Clock period in simulation time units

  // Inputs
  reg clk;
  reg rst_n;
  reg [2:0] data;

  // Outputs
  wire sequence_found;

  // Instantiate the sequence detector module
  SequenceDetector dut (
    .clk(clk),
    .rst_n(rst_n),
    .data(data),
    .sequence_found(sequence_found)
  );

  // Clock generation
  always begin
    #(CLK_PERIOD/2) clk = ~clk;
  end

  // Reset generation
  initial begin
    rst_n = 0;
    #(3 * CLK_PERIOD);
    rst_n = 1;
  end

  // Test input sequence
  reg [7:0] test_sequence = 8'b00110110;
  reg [7:0] expected_output = 8'b00000001;
  integer test_passed = 1;

  // Apply test sequence and check output
  always @(posedge clk) begin
    if (rst_n) begin
      data <= test_sequence[2:0];
      if (sequence_found !== expected_output)
        test_passed = 0;
    end
    test_sequence <= {test_sequence[5:0], test_sequence[7:6]};
    expected_output <= {expected_output[6:0], expected_output[7]};
  end

  // Simulation end and error reporting
  initial begin
    #100;
    if (test_passed)
      $display("Test passed successfully!");
    else
      $display("Test failed! Check the error.");

    $finish;
  end

endmodule

