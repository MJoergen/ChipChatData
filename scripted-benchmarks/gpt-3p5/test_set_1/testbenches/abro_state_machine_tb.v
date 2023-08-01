module ABRO_StateMachine_Testbench;

  // Parameters
  parameter PERIOD = 10;  // Clock period in time units

  // Inputs
  reg clk;
  reg resetn;
  reg A;
  reg B;

  // Outputs
  wire O;
  wire [3:0] state;

  // Instantiate the DUT
  ABRO_StateMachine dut (
    .clk(clk),
    .resetn(resetn),
    .A(A),
    .B(B),
    .O(O),
    .state(state)
  );

  // Clock generation
  always begin
    #((PERIOD/2)); clk = ~clk;
  end

  // Reset generation
  initial begin
    resetn = 0;
    #10; resetn = 1;
  end

  // Test cases
  initial begin
    // Test case 1: A = 0, B = 0
    A = 0;
    B = 0;
    #(10 * PERIOD);  // Wait for 10 clock cycles
    if (O !== 1'b0 || state !== 4'b0001)
      $display("Test case 1 failed! O=%b, state=%b", O, state);
    else
      $display("Test case 1 passed!");

    // Test case 2: A = 0, B = 1
    A = 0;
    B = 1;
    #(10 * PERIOD);  // Wait for 10 clock cycles
    if (O !== 1'b0 || state !== 4'b0010)
      $display("Test case 2 failed! O=%b, state=%b", O, state);
    else
      $display("Test case 2 passed!");

    // Test case 3: A = 1, B = 1
    A = 1;
    B = 1;
    #(10 * PERIOD);  // Wait for 10 clock cycles
    if (O !== 1'b0 || state !== 4'b0010)
      $display("Test case 3 failed! O=%b, state=%b", O, state);
    else
      $display("Test case 3 passed!");

    // Test case 4: A = 1, B = 0
    A = 1;
    B = 0;
    #(10 * PERIOD);  // Wait for 10 clock cycles
    if (O !== 1'b0 || state !== 4'b0011)
      $display("Test case 4 failed! O=%b, state=%b", O, state);
    else
      $display("Test case 4 passed!");

    // Test case 5: A = 0, B = 1
    A = 0;
    B = 1;
    #(10 * PERIOD);  // Wait for 10 clock cycles
    if (O !== 1'b0 || state !== 4'b0100)
      $display("Test case 5 failed! O=%b, state=%b", O, state);
    else
      $display("Test case 5 passed!");

    // Test case 6: A = 1, B = 0
    A = 1;
    B = 0;
    #(10 * PERIOD);  // Wait for 10 clock cycles
    if (O !== 1'b0 || state !== 4'b0011)
      $display("Test case 6 failed! O=%b, state=%b", O, state);
    else
      $display("Test case 6 passed!");

    // Test case 7: A = 0, B = 0
    A = 0;
    B = 0;
    #(10 * PERIOD);  // Wait for 10 clock cycles
    if (O !== 1'b1 || state !== 4'b0001)
      $display("Test case 7 failed! O=%b, state=%b", O, state);
    else
      $display("Test case 7 passed!");

    // Add more test cases as needed

    // End simulation
    $finish;
  end

endmodule

