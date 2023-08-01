module ShiftRegister_TB;

  // Parameters
  parameter CLK_PERIOD = 10; // Clock period in simulation time units

  // Inputs
  reg clock;
  reg reset_n;
  reg data;
  reg shift_enable;

  // Outputs
  wire [7:0] output_data;

  // Instantiate the ShiftRegister module
  ShiftRegister dut (
    .clock(clock),
    .reset_n(reset_n),
    .data(data),
    .shift_enable(shift_enable),
    .output_data(output_data)
  );

  // Testbench initialization
  initial begin
    // Initialize inputs
    clock = 0;
    reset_n = 1;
    data = 1'b0;
    shift_enable = 1'b0;

    // Apply reset
    reset_n = 0;
    #5; // Hold reset for 5 time units

    reset_n = 1;
    #5; // Wait for 5 time units after releasing reset

    // Test case 1: Shift in data '1' and verify output
    data = 1'b1;
    shift_enable = 1'b1;
    #20; // Wait for 20 time units

    // Delay corresponding to the number of places the data should shift
    #(8 * CLK_PERIOD);

    // Check output_data
    if (output_data !== 8'b00000001) $error("Test case 1 failed");

    // Test case 2: Shift in data '0' and verify output
    data = 1'b0;
    shift_enable = 1'b1;
    #20; // Wait for 20 time units

    // Delay corresponding to the number of places the data should shift
    #(8 * CLK_PERIOD);

    // Check output_data
    if (output_data !== 8'b00000010) $error("Test case 2 failed");

    // Test case 3: Shift enable low, output should remain unchanged
    shift_enable = 1'b0;
    #20; // Wait for 20 time units

    // Delay corresponding to the number of places the data should shift
    #(0 * CLK_PERIOD);

    // Check output_data
    if (output_data !== 8'b00000010) $error("Test case 3 failed");

    // Add more test cases as needed...

    // End simulation
    $display("Simulation completed successfully!");
    $finish;
  end

  // Clock generation
  always #((CLK_PERIOD)/2) clock = ~clock;

endmodule

