module full_tb ();

	reg [7:0] io_in;
	wire [7:0] io_out;

	jblocklove_cgpt_benchmark_wrapper uut (.io_in(io_in), .io_out(io_out));

	// Test cases
	parameter NUM_TEST_CASES = 8;

	reg [7:0] test_case_input [0:NUM_TEST_CASES-1];
	reg [7:0] test_case_expected [0:NUM_TEST_CASES-1];

	// Test case setup
	initial begin
		test_case_input[0] = 8'b00000101;
		test_case_input[1] = 8'b00110000;
		test_case_input[2] = 8'b01001101;
		test_case_input[3] = 8'b01100001;
		test_case_input[4] = 8'b10011100;
		test_case_input[5] = 8'b10100011;
		test_case_input[6] = 8'b11001011;
		test_case_input[7] = 8'b11111011;
	end

	initial begin
		test_case_expected[0] = 8'b00000001;
		test_case_expected[1] = 8'b00000011;
		test_case_expected[2] = 8'b10000000;
		test_case_expected[3] = 8'b00011000;
		test_case_expected[4] = 8'b00010001;
		test_case_expected[5] = 8'b00100000;
		test_case_expected[6] = 8'b11100000;
		test_case_expected[7] = 8'b10000001;
	end

	reg clk_en = 1'b1;

	// Stimulus process
	integer i;
	integer errors = 0;
	initial begin

		for (i = 0; i < 8; i = i + 1) begin
			io_in <= test_case_input[i];
			#10;
			if (io_out != test_case_expected[i]) begin
				$display("Test Case %d Failed: Expected Output = %b, Actual Output = %b", i, test_case_expected[i], io_out);
				errors = errors + 1;
			end
		end

        // Report the overall test results
        if (errors == 0) begin
            $display("All test cases passed");
        end
		else begin
            $display("Total errors: %0d", errors);
        end
		$finish;

	end

endmodule

