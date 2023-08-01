module DiceRoller_TB;
  reg clk;
  reg reset_n;
  reg [1:0] die_select;
  reg roll;
  wire [7:0] rolled_number;

  initial begin
    // Initialize inputs
    clk = 0;
    reset_n = 0;
    die_select = 2'b00;
    roll = 0;

    // Run test cases
    @(posedge clk); // Wait for a positive edge to start the simulation

    // Test Case 1: Roll a 4-sided die
    $display("Test Case 1: Roll a 4-sided die");
    die_select = 2'b00;
    roll = 1;
    @(posedge clk); // Wait for a positive edge to sample the output
    if (rolled_number !== 4'b0000) begin
      $display("Test Case 1 failed: Incorrect rolled number");
      $finish;
    end

    // Test Case 2: Roll a 6-sided die
    $display("Test Case 2: Roll a 6-sided die");
    die_select = 2'b01;
    roll = 1;
    @(posedge clk); // Wait for a positive edge to sample the output
    if (rolled_number !== 6'b000000) begin
      $display("Test Case 2 failed: Incorrect rolled number");
      $finish;
    end

    // Test Case 3: Roll an 8-sided die
    $display("Test Case 3: Roll an 8-sided die");
    die_select = 2'b10;
    roll = 1;
    @(posedge clk); // Wait for a positive edge to sample the output
    if (rolled_number !== 8'b00000000) begin
      $display("Test Case 3 failed: Incorrect rolled number");
      $finish;
    end

    // Test Case 4: Roll a 20-sided die
    $display("Test Case 4: Roll a 20-sided die");
    die_select = 2'b11;
    roll = 1;
    @(posedge clk); // Wait for a positive edge to sample the output
    if (rolled_number !== 20'b00000000000000000000) begin
      $display("Test Case 4 failed: Incorrect rolled number");
      $finish;
    end

    // Test Case 5: Roll a 6-sided die with multiple rolls
    $display("Test Case 5: Roll a 6-sided die with multiple rolls");
    die_select = 2'b01;
    roll = 0;
    @(posedge clk); // Wait for a positive edge to sample the output
    if (rolled_number !== 6'b000000) begin
      $display("Test Case 5 failed: Incorrect rolled number");
      $finish;
    end

    roll = 1;
    @(posedge clk); // Wait for a positive edge to sample the output
    if (rolled_number < 6'b000000 || rolled_number > 6'b111111) begin
      $display("Test Case 5 failed: Incorrect rolled number");
      $finish;
    end

    roll = 0;
    @(posedge clk); // Wait for a positive edge to sample the output
	// Test Case 5: Roll a 6-sided die with multiple rolls (continued)
    if (rolled_number < 6'b000000 || rolled_number > 6'b111111) begin
      $display("Test Case 5 failed: Incorrect rolled number");
      $finish;
    end

    // Finish the simulation
    $display("All test cases passed successfully");
    $finish;
  end

  always #5 clk = ~clk; // Toggle the clock every 5 time units

  // Instantiate the DiceRoller module
  DiceRoller DUT (
    .clk(clk),
    .reset_n(reset_n),
    .die_select(die_select),
    .roll(roll),
    .rolled_number(rolled_number)
  );
endmodule


