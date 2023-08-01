`timescale 1ns/1ps

module ShiftRegister_TB;

  reg clk;
  reg reset;
  reg data;
  reg shift_enable;
  wire [7:0] output_data;

  // Instantiate the shift register module
  ShiftRegister dut (
    .clk(clk),
    .reset(reset),
    .data(data),
    .shift_enable(shift_enable),
    .output_data(output_data)
  );

  // Define the clock generator
  always #5 clk = ~clk;

  // Initialize the inputs and release reset
  initial begin
    clk = 0;
    reset = 0;  // Initialize reset to 0
    data = 0;
    shift_enable = 0;

    // Reset sequence
    #10 reset = 1;  // Assert reset
    #20 reset = 0;  // Deassert reset

    // Delay after releasing reset
    #10;

    // Test case 1: Shift in '1' bit
    data = 1;
    #5 shift_enable = 1;  // Align signal transition with clock edge
    #5 shift_enable = 0;  // Align signal transition with clock edge
    #25;  // Delay to allow output stabilization
    if (output_data !== 8'b00000001) begin
      $display("Test case 1 failed: Expected 8'b00000001, Actual %b", output_data);
    end

    // Test case 2: Shift in '0' bit
    data = 0;
    #5 shift_enable = 1;  // Align signal transition with clock edge
    #5 shift_enable = 0;  // Align signal transition with clock edge
    #25;  // Delay to allow output stabilization
    if (output_data !== 8'b00000010) begin
      $display("Test case 2 failed: Expected 8'b00000010, Actual %b", output_data);
    end

    // Test case 3: Shift in '1' bit again
    data = 1;
    #5 shift_enable = 1;  // Align signal transition with clock edge
    #5 shift_enable = 0;  // Align signal transition with clock edge
    #25;  // Delay to allow output stabilization
    if (output_data !== 8'b00000101) begin
      $display("Test case 3 failed: Expected 8'b00000101, Actual %b", output_data);
    end

    // Add more test cases here...

    // Finish simulation
    #10 $finish;
  end

endmodule

