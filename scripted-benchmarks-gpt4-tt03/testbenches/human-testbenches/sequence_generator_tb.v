`timescale 1ns/1ps

module tb_sequence_generator;
    reg clock = 0;
    reg reset_n;
    reg enable;
    wire [7:0] data;

    // Instantiate the shift_register module
    sequence_generator seq_gen (
        .clock(clock),
        .reset_n(reset_n),
        .enable(enable),
        .data(data)
    );

	// Test cases
	localparam NUM_TESTS = 12;
	reg [1:0] test_case_input [0:NUM_TESTS-1];
	reg [7:0] test_case_expected [0:NUM_TESTS-1];

    // Clock generation
    always begin
        #5 clock = ~clock;
    end

	// Test case setup
	initial begin
		test_case_input[0] = 2'b00;
		test_case_input[1] = 2'b01;
		test_case_input[2] = 2'b11;
		test_case_input[3] = 2'b11;
		test_case_input[4] = 2'b11;
		test_case_input[5] = 2'b11;
		test_case_input[6] = 2'b11;
		test_case_input[7] = 2'b11;
		test_case_input[8] = 2'b11;
		test_case_input[9] = 2'b01;
		test_case_input[10] = 2'b11;
		test_case_input[11] = 2'b10;
	end

	initial begin
		test_case_expected[0] = 8'b10101111;
		test_case_expected[1] = 8'b10101111;
		test_case_expected[2] = 8'b10101111;
		test_case_expected[3] = 8'b10111100;
		test_case_expected[4] = 8'b11100010;
		test_case_expected[5] = 8'b01111000;
		test_case_expected[6] = 8'b11111111;
		test_case_expected[7] = 8'b11100010;
		test_case_expected[8] = 8'b00001011;
		test_case_expected[9] = 8'b10001101;
		test_case_expected[10] = 8'b10001101;
		test_case_expected[11] = 8'b10101111;
	end


    // Testbench stimulus
	integer i;
	integer errors = 0;
    initial begin
		// Stimulus
		for (i = 0; i < NUM_TESTS; i = i + 1) begin
			reset_n = test_case_input[i][0];
			enable = test_case_input[i][1];
			@(posedge clock);
			if (data !== test_case_expected[i]) begin
				$display("Error: Test case %d failed. Expected: 0x%h, Received: 0x%h", i, test_case_expected[i], data);
				errors = errors + 1;
			end
		end

		// Display results
		if (errors == 0) begin
			$display("All tests passed!");
		end else begin
			$display("%d tests failed!", errors);
		end

		$finish;
    end

	reg vcd_clk;
	initial begin
	    $dumpfile("sequence_generator_tb.vcd");
	    $dumpvars(0, tb_sequence_generator);
	end

	always #5 vcd_clk = ~vcd_clk; // Toggle clock every 5 time units


endmodule


