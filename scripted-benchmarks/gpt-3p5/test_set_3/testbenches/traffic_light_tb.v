module TrafficLight_TB;

  reg clk;
  reg reset_n;
  reg enable;
  wire red;
  wire yellow;
  wire green;

  reg tb_red;
  reg tb_yellow;
  reg tb_green;

  // Instantiate the DUT
  TrafficLight dut (
    .clk(clk),
    .reset_n(reset_n),
    .enable(enable),
    .red(tb_red),
    .yellow(tb_yellow),
    .green(tb_green)
  );

  // Clock generation
  always #5 clk = ~clk;

  initial begin
    clk = 0;
    reset_n = 0;
    enable = 0;

    // Reset test
    #10 reset_n = 1;

    // Wait for the traffic light to stabilize in the red state
    #50;

    // Test initial state (RED)
    tb_red = 1'b1;
    tb_yellow = 1'b0;
    tb_green = 1'b0;
    if (!tb_red || tb_yellow || tb_green)
      $display("Test failed: Initial state is incorrect.");

    // Test state transition from RED to GREEN
    enable = 1;
    repeat (32) @(posedge clk);
    tb_red = 1'b0;
    tb_yellow = 1'b0;
    tb_green = 1'b1;
    if (tb_red || tb_yellow || !tb_green)
      $display("Test failed: Incorrect transition from RED to GREEN.");

    // Test state transition from GREEN to YELLOW
    repeat (20) @(posedge clk);
    tb_red = 1'b0;
    tb_yellow = 1'b1;
    tb_green = 1'b0;
    if (tb_red || !tb_yellow || tb_green)
      $display("Test failed: Incorrect transition from GREEN to YELLOW.");

    // Test state transition from YELLOW to RED
    repeat (7) @(posedge clk);
    tb_red = 1'b1;
    tb_yellow = 1'b0;
    tb_green = 1'b0;
    if (!tb_red || tb_yellow || tb_green)
      $display("Test failed: Incorrect transition from YELLOW to RED.");

    // Test repeated state transitions
    integer i;
    for (i = 0; i < 3; i = i + 1) begin
      // Test state transition from RED to GREEN
      repeat (32) @(posedge clk);
      tb_red = 1'b0;
      tb_yellow = 1'b0;
      tb_green = 1'b1;
      if (tb_red || tb_yellow || !tb_green)
        $display("Test failed: Incorrect transition from RED to GREEN.");

      // Test state transition from GREEN to YELLOW
      repeat (20) @(posedge clk);
      tb_red = 1'b0;
      tb_yellow = 1'b1;
      tb_green = 1'b0;
      if (tb_red || !tb_yellow || tb_green)
        $display("Test failed: Incorrect transition from GREEN to YELLOW.");

      // Test state transition from YELLOW to RED
      repeat (7) @(posedge clk);
      tb_red = 1'b1;
      tb_yellow = 1'b0;
      tb_green = 1'b0;
      if (!tb_red || tb_yellow || tb_green)
        $display("Test failed: Incorrect transition from YELLOW to RED.");
    end

    // Assign final values to the outputs
    red = tb_red;
    yellow = tb_yellow;
    green = tb_green;

    $display("Testbench completed successfully.");
    $finish;
  end

endmodule

