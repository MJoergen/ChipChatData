module SequenceGenerator_TB;

  // Parameters
  parameter CYCLE_DELAY = 5;  // Delay between clock cycles
  parameter NUM_CYCLES = 100; // Number of clock cycles to simulate

  // Signals
  reg clk;
  reg reset_n;
  reg enable;
  wire [7:0] data;

  // Instantiate the sequence generator
  SequenceGenerator dut (
    .clk(clk),
    .reset_n(reset_n),
    .enable(enable),
    .data(data)
  );

  // Clock generation
  always #((CYCLE_DELAY/2)) clk = ~clk;

  // Expected sequence values
  reg [7:0] expected_sequence [8:1] = '{8'hAF, 8'hBC, 8'hE2, 8'h78, 8'hFF, 8'hE2, 8'h0B, 8'h8D};

  // Initialize signals
  initial begin
    clk = 0;
    reset_n = 0;
    enable = 0;

    // Reset sequence generator
    #10;
    reset_n = 1;
    #10;

    // Enable sequence generator
    enable = 1;
    #10;

    // Validate the generated sequence
    integer i;
    for (i = 0; i < NUM_CYCLES; i = i + 1) begin
      // Check for correct sequence value
      if (data !== expected_sequence[(i % 8) + 1]) begin
        $error("Incorrect sequence value at cycle %d. Expected: 0x%h, Got: 0x%h",
               i, expected_sequence[(i % 8) + 1], data);
      end

      #10;
    end

    $display("Sequence generator testbench completed successfully.");
    $finish;
  end

endmodule

