`timescale 1ns / 1ps

module sequence_detector_tb;
    reg clk;
    reg reset_n;
    reg [2:0] data;
    wire sequence_found;

    sequence_detector uut (
        .clk(clk),
        .reset_n(reset_n),
        .data(data),
        .sequence_found(sequence_found)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Test cases
    reg [2:0] test_case_data [0:7];
    reg [0:7] expected_sequence_found;

    integer i;

    initial begin
        // Initialize test cases
        test_case_data[0] = 3'b001; expected_sequence_found[0] = 1'b0;
        test_case_data[1] = 3'b101; expected_sequence_found[1] = 1'b0;
        test_case_data[2] = 3'b110; expected_sequence_found[2] = 1'b0;
        test_case_data[3] = 3'b000; expected_sequence_found[3] = 1'b0;
        test_case_data[4] = 3'b110; expected_sequence_found[4] = 1'b0;
        test_case_data[5] = 3'b110; expected_sequence_found[5] = 1'b0;
        test_case_data[6] = 3'b011; expected_sequence_found[6] = 1'b1;
        test_case_data[7] = 3'b101; expected_sequence_found[7] = 1'b0;

        // Initialize signals
        clk = 0;
        reset_n = 0;
        data = 0;

        // Apply reset
        #10 reset_n = 1;

        // Start simulation
        $display("Starting simulation...");
        for (i = 0; i < 8; i = i + 1) begin
            // Apply test case data
            data = test_case_data[i];
            #10;

            // Check output
            if (sequence_found !== expected_sequence_found[i]) begin
                $display("Error: Test case %0d failed. data: %b, expected sequence_found: %b, got: %b",
                         i, test_case_data[i], expected_sequence_found[i], sequence_found);
            end else begin
                $display("Test case %0d passed.", i);
            end
        end

        // Finish simulation
        $display("Simulation finished.");
        $finish;
    end

endmodule

