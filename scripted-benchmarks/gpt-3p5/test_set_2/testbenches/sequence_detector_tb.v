module SequenceDetector_TB;

  // Parameters
  parameter CLOCK_PERIOD = 10;  // Clock period in simulation time units

  // Inputs
  reg clk;
  reg reset_n;
  reg [2:0] data;

  // Outputs
  wire sequence_found;

  // Instantiate the SequenceDetector module
  SequenceDetector dut (
    .clk(clk),
    .reset_n(reset_n),
    .data(data),
    .sequence_found(sequence_found)
  );

  // Initialize signals
  initial begin
    clk = 0;
    reset_n = 1;
    data = 3'b0;
    #2;  // Allow some time for initialization
    run_test();  // Start the test
  end

  // Clock generation
  always #(CLOCK_PERIOD/2) clk = ~clk;

  // Test procedure
  task run_test();
    begin
      // Test case 1: Valid sequence
      #10;
      data = 3'b001;
      #10;
      data = 3'b101;
      #10;
      data = 3'b110;
      #10;
      data = 3'b000;
      #10;
      data = 3'b110;
      #10;
      data = 3'b110;
      #10;
      data = 3'b011;
      #10;
      data = 3'b101;
      #10;

      // Test case 2: Invalid sequence
      #10;
      data = 3'b001;
      #10;
      data = 3'b101;
      #10;
      data = 3'b110;
      #10;
      data = 3'b000;
      #10;
      data = 3'b110;
      #10;
      data = 3'b110;
      #10;
      data = 3'b011;
      #10;
      data = 3'b111;  // Invalid input
      #10;

      // Test case 3: Reset during sequence detection
      #10;
      data = 3'b001;
      #10;
      data = 3'b101;
      #10;
      data = 3'b110;
      #10;
      reset_n = 0;  // Assert reset
      #10;
      reset_n = 1;  // De-assert reset
      #10;
      data = 3'b110;
      #10;
      data = 3'b110;
      #10;
      data = 3'b011;
      #10;
      data = 3'b101;
      #10;

      $finish;  // End simulation
    end
  endtask

endmodule

