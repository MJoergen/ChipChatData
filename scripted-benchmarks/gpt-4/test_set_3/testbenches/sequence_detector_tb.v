`timescale 1ns/1ps

module tb_sequence_detector();

reg clk;
reg reset_n;
reg [2:0] data;
wire sequence_found;

// Instantiate the sequence_detector module
sequence_detector sequence_detector_inst (
    .clk(clk),
    .reset_n(reset_n),
    .data(data),
    .sequence_found(sequence_found)
);

// Clock generation
always begin
    #5 clk = ~clk;
end

integer test_case_count;
integer errors;

// Stimulus generation and checking
initial begin
    // Initialize variables
    test_case_count = 0;
    errors = 0;

    // Initialize signals
    clk = 1'b0;
    reset_n = 1'b0;
    data = 3'b000;

    // Apply reset
    #10 reset_n = 1'b1;

    // Test case 1: Test sequence
    test_case_count = test_case_count + 1;
    data = 3'b001; #10;
    data = 3'b101; #10;
    data = 3'b110; #10;
    data = 3'b000; #10;
    data = 3'b110; #10;
    data = 3'b110; #10;
    data = 3'b011; #10;
    data = 3'b101; #10;
    if (sequence_found !== 1'b1) begin
        $display("Error: Test case %0d failed! Expected sequence_found = 1, got sequence_found = %0d", test_case_count, sequence_found);
        errors = errors + 1;
    end

    // Test case 2: Partial sequence
    test_case_count = test_case_count + 1;
    data = 3'b001; #10;
    data = 3'b101; #10;
    data = 3'b110; #10;
    data = 3'b110; #10;
    if (sequence_found !== 1'b0) begin
        $display("Error: Test case %0d failed! Expected sequence_found = 0, got sequence_found = %0d", test_case_count, sequence_found);
        errors = errors + 1;
    end

    // Test case 3: Reset during sequence
    test_case_count = test_case_count + 1;
    data = 3'b001; #10;
    data = 3'b101; #10;
    reset_n = 1'b0; #10;
    reset_n = 1'b1; #10;
    data = 3'b110; #10;
    data = 3'b000; #10;
    if (sequence_found !== 1'b0) begin
        $display("Error: Test case %0d failed! Expected sequence_found = 0, got sequence_found = %0d", test_case_count, sequence_found);
        errors = errors + 1;
    end

    // Check for errors and finish the simulation
    if (errors == 0) begin
        $display("All %0d test cases passed.", test_case_count);
    end else begin
        $display("%0d out of %0d test cases failed.", errors, test_case_count);
    end
    $finish;
end

endmodule

