`timescale 1ns / 1ps

module tb_shift_register;
    reg clk;
    reg reset_n;
    reg data_in;
    reg shift_enable;
    wire [7:0] data_out;

    // Instantiate the shift_register module
    shift_register my_shift_register (
        .clk(clk),
        .reset_n(reset_n),
        .data_in(data_in),
        .shift_enable(shift_enable),
        .data_out(data_out)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;
    end

    // Testbench stimulus
    initial begin
        // Initialize signals
        clk = 0;
        reset_n = 1;
        data_in = 0;
        shift_enable = 0;

        // Test case 1: Active-low reset
        reset_n = 0;
        #10 reset_n = 1;
        @(posedge clk);
        check_data_out(8'b0, "Reset");

        // Test case 2: Shift operation
        shift_enable = 1;
        data_in = 1;
        @(posedge clk); // Shift the first '1'
        @(posedge clk); // Shift the second '1'
        @(posedge clk); // Wait for the rising edge of the clock
        check_data_out(8'b11000000, "Shift 1");

        data_in = 0;
        repeat(6) @(posedge clk);
        @(posedge clk); // Wait for the rising edge of the clock
        check_data_out(8'b01000000, "Shift 2");

        // Test case 3: Shift with different data patterns
        data_in = 1;
        repeat(8) @(posedge clk);
        @(posedge clk); // Wait for the rising edge of the clock
        check_data_out(8'b11111111, "Shift 3");

        data_in = 0;
        shift_enable = 0;
        repeat(8) @(posedge clk);
        @(posedge clk); // Wait for the rising edge of the clock
        check_data_out(8'b11111111, "Shift 4 (disabled)");

        // Test case 4: Finish the test
        $display("All tests passed!");
        $finish;
    end

    // Task to check the data_out and display test result
    task check_data_out;
        input [7:0] expected_value;
        input [100:0] test_name;
        begin
            if (data_out !== expected_value) begin
                $display("Test %s failed: Expected %b, but got %b", test_name, expected_value, data_out);
                $finish;
            end else begin
                $display("Test %s passed", test_name);
            end
        end
    endtask

endmodule

