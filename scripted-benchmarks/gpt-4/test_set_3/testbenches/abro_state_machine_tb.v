`timescale 1ns/1ps

module tb_abro_fsm();
    reg clk;
    reg reset_n;
    reg A;
    reg B;
    wire O;
    wire [3:0] State;

    // Instantiate the ABRO state machine
    abro_fsm abro_fsm_inst (
        .clk(clk),
        .reset_n(reset_n),
        .A(A),
        .B(B),
        .O(O),
        .State(State)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;
    end

    // Test scenario task
    task test_scenario(input reg expected_O,
                       input reg [3:0] expected_State,
                       input reg A_input,
                       input reg B_input);
        begin
            A = A_input;
            B = B_input;
            #10; // Wait for the state to change
            if (O !== expected_O || State !== expected_State) begin
                $display("Error: A = %b, B = %b, Expected O = %b, Actual O = %b, Expected State = 4'b%b, Actual State = 4'b%b",
                          A_input, B_input, expected_O, O, expected_State, State);
                $finish;
            end
        end
    endtask

    // Testbench stimulus
    initial begin
        // Initialize signals
        clk = 0;
        reset_n = 1;
        A = 0;
        B = 0;

        // Apply reset
        reset_n = 0;
        #10 reset_n = 1;
        #10; // Wait for any additional settling

        // Test scenarios
        test_scenario(1'b0, 4'b0001, 1'b0, 1'b0); // S0, A=0, B=0
        test_scenario(1'b0, 4'b0010, 1'b1, 1'b0); // S1, A=1, B=0
        test_scenario(1'b1, 4'b0100, 1'b0, 1'b1); // S2, A=0, B=1
        test_scenario(1'b0, 4'b1000, 1'b1, 1'b0); // S3, A=1, B=0
        test_scenario(1'b0, 4'b0010, 1'b0, 1'b1); // S1, A=0, B=1
        test_scenario(1'b1, 4'b0100, 1'b1, 1'b1); // S2, A=1, B=1
		test_scenario(1'b0, 4'b0001, 1'b0, 1'b0); // S0, A=0, B=0
        test_scenario(1'b0, 4'b0010, 1'b1, 1'b1); // S1, A=1, B=1
        test_scenario(1'b0, 4'b0001, 1'b0, 1'b0); // S0, A=0, B=0

    $display("All test cases passed!");
    $finish;
end

endmodule

