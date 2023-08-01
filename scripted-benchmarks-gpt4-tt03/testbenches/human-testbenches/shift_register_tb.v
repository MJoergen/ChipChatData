`timescale 1ns/1ps

module tb_shift_register;
    reg clk = 0;
    reg reset_n;
    reg data_in;
    reg shift_enable;
    wire [7:0] data_out;

    // Instantiate the shift_register module
    shift_register uut (
        .clk(clk),
        .reset_n(reset_n),
        .data_in(data_in),
        .shift_enable(shift_enable),
        .data_out(data_out)
    );

	// Test cases
	localparam NUM_TESTS = 9;
	reg [2:0] test_case_input [0:NUM_TESTS-1];
	reg [7:0] test_case_expected [0:NUM_TESTS-1];

    // Clock generation
    always begin
        #5 clk = ~clk;
    end

	// Test case setup
	initial begin
		test_case_input[0] = 3'b000;
		test_case_input[1] = 3'b001;
		test_case_input[2] = 3'b011;
		test_case_input[3] = 3'b111;
		test_case_input[4] = 3'b111;
		test_case_input[5] = 3'b101;
		test_case_input[6] = 3'b111;
		test_case_input[7] = 3'b011;
		test_case_input[8] = 3'b110;
	end

	initial begin
		test_case_expected[0] = 8'b00000000;
		test_case_expected[1] = 8'b00000000;
		test_case_expected[2] = 8'b00000000;
		test_case_expected[3] = 8'b00000001;
		test_case_expected[4] = 8'b00000011;
		test_case_expected[5] = 8'b00000110;
		test_case_expected[6] = 8'b00001101;
		test_case_expected[7] = 8'b00001101;
		test_case_expected[8] = 8'b00000000;
	end


    // Testbench stimulus
	integer i;
	integer errors = 0;
    initial begin
		// Stimulus
		for (i = 0; i < NUM_TESTS; i = i + 1) begin
			reset_n = test_case_input[i][0];
			data_in = test_case_input[i][1];
			shift_enable = test_case_input[i][2];
			@(posedge clk);
			if (data_out !== test_case_expected[i]) begin
				$display("Error: Test case %d failed. Expected: %b, Received: %b", i, test_case_expected[i], data_out);
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
	    $dumpfile("shift_register_tb.vcd");
	    $dumpvars(0, tb_shift_register);
	end

	always #5 vcd_clk = ~vcd_clk; // Toggle clock every 5 time units


endmodule

