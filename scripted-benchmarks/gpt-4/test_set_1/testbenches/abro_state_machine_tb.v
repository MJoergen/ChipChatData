`timescale 1ns / 1ps

module tb_abro_state_machine;

reg clk;
reg reset_n;
reg A;
reg B;
wire O;
wire [3:0] state;

// Instantiate the abro_state_machine module
abro_state_machine uut (
    .clk(clk),
    .reset_n(reset_n),
    .A(A),
    .B(B),
    .O(O),
    .state(state)
);

// Clock generation
parameter CLK_PERIOD = 10; // 10ns clock period
always begin
    # (CLK_PERIOD / 2) clk = ~clk;
end

// Testbench logic
integer test_case;
integer errors;
integer i;

reg [7:0] test_cases [0:7];
initial begin
    // Initialize variables
    clk = 0;
    reset_n = 0;
    A = 0;
    B = 0;
    test_case = 0;
    errors = 0;

    // Reset the state machine
    #CLK_PERIOD reset_n = 1;

	// Test cases
    // Format: {A, B, expected_O, expected_state}
    test_cases[0] = 8'h01; // Test case 0: {A:0, B:0, O:0, state:IDLE}
    test_cases[1] = 8'h82; // Test case 1: {A:1, B:0, O:0, state:STATE_A}
    test_cases[2] = 8'h44; // Test case 2: {A:0, B:1, O:0, state:STATE_B}
    test_cases[3] = 8'hE8; // Test case 3: {A:1, B:1, O:1, state:STATE_O}
    test_cases[4] = 8'h01; // Test case 4: {A:0, B:0, O:0, state:IDLE} (from STATE_O)
    test_cases[5] = 8'h01; // Test case 5: {A:0, B:0, O:0, state:IDLE} (back to IDLE)


    // Run test cases
    for (i = 0; i < 6; i = i + 1) begin
        A = test_cases[i][7];
        B = test_cases[i][6];

        #CLK_PERIOD; // Wait for one clock cycle

        if (O !== test_cases[i][5] || state !== test_cases[i][3:0]) begin
            $display("Error: Test case %0d failed", i);
            $display("  Inputs: A = %0d, B = %0d", A, B);
            $display("  Expected: O = %0d, state = 4'b%b", test_cases[i][5], test_cases[i][3:0]);
            $display("  Actual: O = %0d, state = 4'b%b", O, state);
            errors = errors + 1;
        end else begin
            $display("Test case %0d passed", i);
        end
    end

    // Display test results
    if (errors == 0) begin
        $display("All test cases passed!");
    end else begin
        $display("%0d test case(s) failed", errors);
    end

    // Finish the simulation
    $finish;
end

endmodule

