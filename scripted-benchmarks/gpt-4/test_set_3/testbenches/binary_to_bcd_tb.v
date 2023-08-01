`timescale 1ns / 1ps

module tb_binary_to_bcd;
    reg [4:0] binary_input;
    wire [3:0] tens, ones;

    // Instantiate the binary_to_bcd module
    binary_to_bcd uut (
        .binary_input(binary_input),
        .tens(tens),
        .ones(ones)
    );

    integer test_index;
    reg [7:0] num_passed = 0;
    reg [3:0] expected_tens_value;
    reg [3:0] expected_ones_value;

    initial begin
        for (test_index = 0; test_index < 32; test_index++) begin
            binary_input = test_index;
            #10; // Wait for the outputs to update

            expected_tens_value = test_index / 10;
            expected_ones_value = test_index % 10;

            if (tens === expected_tens_value && ones === expected_ones_value) begin
                num_passed = num_passed + 1;
            end else begin
                $display("Error: Test case %0d failed", test_index);
                $display("  Input : 5'b%b", binary_input);
                $display("  Expected tens: 4'b%b, ones: 4'b%b", expected_tens_value, expected_ones_value);
                $display("  Actual tens  : 4'b%b, ones: 4'b%b", tens, ones);
            end
        end

        $display("%0d of %0d tests passed", num_passed, 32);
        $finish;
    end

reg vcd_clk;
initial begin
    $dumpfile("my_design.vcd");
    $dumpvars(0, tb_binary_to_bcd);
end

always #5 vcd_clk = ~vcd_clk; // Toggle clock every 5 time units


endmodule

