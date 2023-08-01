`timescale 1ns/1ps

module tb_lfsr_8bit();
    reg clk;
    reg reset_n;
    wire [7:0] data;

    // Instantiate the lfsr_8bit module
    lfsr_8bit uut (
        .clk(clk),
        .reset_n(reset_n),
        .data(data)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;
    end

    // Declare variables
    integer i;
    integer error_count;
    reg [7:0] expected_data;

    // Testbench procedure
    initial begin
        error_count = 0;

        // Initialize clock and reset signals
        clk = 0;
        reset_n = 1;

        // Apply reset
        reset_n = 0;
        #10 reset_n = 1;

        // Check the initial state
        expected_data = 8'b10001010;
        if (data !== expected_data) begin
            $display("Error: Initial state mismatch. Expected: %b, Got: %b", expected_data, data);
            error_count = error_count + 1;
        end

        // Run simulation for a number of cycles and compare the output
        for (i = 0; i < 256; i = i + 1) begin
            #10; // Wait for the next clock cycle

            // Calculate the expected data
            expected_data = {expected_data[7] ^ expected_data[6] ^ expected_data[4] ^ expected_data[1], expected_data[7:1]};

            if (data !== expected_data) begin
                $display("Error: Cycle %d. Expected: %b, Got: %b", i, expected_data, data);
                error_count = error_count + 1;
            end
        end

        // Display test results
        if (error_count == 0) begin
            $display("Test passed!");
        end else begin
            $display("Test failed with %d errors.", error_count);
        end

        // Finish simulation
        $finish;
    end
endmodule

