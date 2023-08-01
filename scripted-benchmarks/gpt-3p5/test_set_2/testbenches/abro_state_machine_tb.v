module ABRO_StateMachine_Testbench;

  // Parameters
  parameter PERIOD = 10; // Clock period in time units

  // Signals
  reg clock;
  reg reset;
  reg A;
  reg B;
  wire O;
  wire [3:0] State;

  // Instantiate the design under test
  ABRO_StateMachine uut (
    .clock(clock),
    .reset(reset),
    .A(A),
    .B(B),
    .O(O),
    .State(State)
  );

  // Clock generation
  always #(PERIOD/2) clock = ~clock;

  // Test stimulus
  initial begin
    // Initialize inputs
    reset = 1;
    A = 0;
    B = 0;

    // Wait for a few clock cycles
    #(10 * PERIOD);

    // Deassert reset
    reset = 0;

    // Test case 1: A=0, B=0
    A = 0;
    B = 0;
    #(4 * PERIOD);

    // Expected results for Test case 1
    if ((State != 4'b0001) || (O != 1'b0)) begin
      $display("Test case 1 failed! Expected State = 0001, O = 0. Got State = %b, O = %b", State, O);
    end

    // Test case 2: A=1, B=0
    A = 1;
    B = 0;
    #(4 * PERIOD);

    // Expected results for Test case 2
    if ((State != 4'b0010) || (O != 1'b1)) begin
      $display("Test case 2 failed! Expected State = 0010, O = 1. Got State = %b, O = %b", State, O);
    end

    // Test case 3: A=1, B=1
    A = 1;
    B = 1;
    #(4 * PERIOD);

    // Expected results for Test case 3
    if ((State != 4'b1000) || (O != 1'b1)) begin
      $display("Test case 3 failed! Expected State = 1000, O = 1. Got State = %b, O = %b", State, O);
    end

    // Test case 4: A=0, B=1
    A = 0;
    B = 1;
    #(4 * PERIOD);

    // Expected results for Test case 4
    if ((State != 4'b0100) || (O != 1'b0)) begin
      $display("Test case 4 failed! Expected State = 0100, O = 0. Got State = %b, O = %b", State, O);
    end

    // Finish simulation
    $display("Simulation complete.");
    $finish;
  end

  // Monitor the signals
  always @(State or O) begin
    $display("Time = %d, State = %b, O = %b",$time, State, O);
  end
endmodule

