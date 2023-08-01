`timescale 1ns/1ps

module tb_lfsr();

reg clk;
reg reset_n;
wire [7:0] data;

// Instantiate the LFSR module
lfsr my_lfsr (
    .clk(clk),
    .reset_n(reset_n),
    .data(data)
);

// Clock generation
always begin
    #5 clk = ~clk;
end

// Testbench stimulus and checker
integer i;
reg [7:0] expected_data [0:255];

initial begin
    // Generate the expected data sequence
    expected_data[0] = 8'b10001010; // Initial state
    for (i = 1; i < 256; i = i + 1) begin
        expected_data[i] = {expected_data[i-1][6:0], expected_data[i-1][0] ^ expected_data[i-1][3] ^ expected_data[i-1][5] ^ expected_data[i-1][6]};
    end

    // Initialize signals
    clk = 0;
    reset_n = 1;

    // Apply reset
    reset_n = 0;
    #10 reset_n = 1;

    // Check LFSR output against expected sequence
    for (i = 0; i < 256; i = i + 1) begin
        @(posedge clk);
        if (data !== expected_data[i]) begin
            $display("Error: At step %0d, expected data: %0b, got: %0b", i, expected_data[i], data);
            $finish;
        end
    end

    // Test passed
    $display("Test passed!");
    $finish;
end

endmodule

