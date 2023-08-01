`timescale 1ns / 1ps

module tb_binary_to_bcd;
    reg [4:0] binary_input;
    wire [3:0] bcd_tens, bcd_units;

    // Instantiate the binary_to_bcd module
    binary_to_bcd b2b (
        .binary_input(binary_input),
        .bcd_tens(bcd_tens),
        .bcd_units(bcd_units)
    );

    integer i;
    reg [7:0] expected_bcd;
    reg [7:0] actual_bcd;
    integer error_count;

    initial begin
        error_count = 0;

        // Test all possible input values
        for (i = 0; i <= 31; i = i + 1) begin
            binary_input = i;

            // Compute the expected BCD value
            expected_bcd[3:0] = i % 10;
            expected_bcd[7:4] = i / 10;

            // Wait for the outputs to update
            #1;

            // Check if the outputs match the expected BCD value
            actual_bcd = {bcd_tens, bcd_units};
            if (actual_bcd !== expected_bcd) begin
                $display("Error: Input = %0d, Expected BCD = %0h, Actual BCD = %0h",
                         i, expected_bcd, actual_bcd);
                error_count = error_count + 1;
            end
        end

        // Report the overall test results
        if (error_count == 0) begin
            $display("All test cases passed!");
        end else begin
            $display("Total errors: %0d", error_count);
        end

        // Finish the simulation
        $finish;
    end
endmodule

