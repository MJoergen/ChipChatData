module ABRO_StateMachine_tb;

  // Parameters
  parameter CLK_PERIOD = 10; // Clock period in time units

  // Signals
  reg clk;
  reg reset_n;
  reg A;
  reg B;
  wire O;
  wire [3:0] State;

  // Instantiate the design under test
  ABRO_StateMachine uut (
    .clk(clk),
    .reset_n(reset_n),
    .A(A),
    .B(B),
    .O(O),
    .State(State)
  );

  // Clock generation
  always begin
    clk = 0;
    #((CLK_PERIOD / 2));
    clk = 1;
    #((CLK_PERIOD / 2));
  end

  // Reset generation
  initial begin
    reset_n = 0;
    #20;
    reset_n = 1;
  end

  // Stimulus generation
  initial begin
    // Test case 1: A -> B -> R -> O -> A
    #10;
    A = 1;
    #10;
    A = 0;
    B = 1;
    #10;
    B = 0;
    #10;
    B = 1;
    #10;
    B = 0;
    #10;
    A = 1;
    #10;
    A = 0;
    #10;
    $finish;
  end

  // Self-checking
  always @(posedge clk) begin
    if (O !== (State == 4'b1000))
      $display("Error: Incorrect output value! O = %b, State = %b", O, State);
  end

endmodule

