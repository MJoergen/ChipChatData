module TrafficLight_TB;

  reg clk;
  reg reset_n;
  reg enable;
  wire red;
  wire yellow;
  wire green;

  TrafficLight dut (
    .clk(clk),
    .reset_n(reset_n),
    .enable(enable),
    .red(red),
    .yellow(yellow),
    .green(green)
  );

  // Clock generation
  always #5 clk = ~clk;

  // Reset initialization
  initial begin
    clk = 1'b0;
    reset_n = 1'b0;
    enable = 1'b0;
    #10 reset_n = 1'b1;
    #10 enable = 1'b1;
    #32 enable = 1'b0; // Transition from S_RED to S_GREEN after 32 cycles
    #20 enable = 1'b0; // Transition from S_GREEN to S_YELLOW after 20 cycles
    #7 enable = 1'b0;  // Transition from S_YELLOW to S_RED after 7 cycles
    #100 $finish; // End simulation after a reasonable time
  end

  // Check expected behavior
  initial begin
    $monitor("Time = %t | State = %b | Red = %b | Yellow = %b | Green = %b",
      $time, dut.state, red, yellow, green);

    // Expected state: S_RED
    #10;
    if (!(reset_n && !enable && red && !yellow && !green))
      $error("Test case 1 failed!");

    // Expected state: S_GREEN
    #32;
    if (!(reset_n && enable && !red && !yellow && green))
      $error("Test case 2 failed!");

    // Expected state: S_YELLOW
    #20;
    if (!(reset_n && enable && !red && yellow && !green))
      $error("Test case 3 failed!");

    // Expected state: S_RED
    #7;
    if (!(reset_n && enable && red && !yellow && !green))
      $error("Test case 4 failed!");

    $finish; // End simulation after all checks
  end

endmodule

