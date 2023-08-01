`timescale 1ns/1ps

module tb_shift_register;
    reg clk;
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

    // Clock generation
    always begin
        #5 clk = ~clk;
    end

    // Testbench stimulus
    initial begin
        // Initialize signals
        clk = 0;
        reset_n = 0;
        data_in = 0;
        shift_enable = 0;

        // Apply reset
        #10 reset_n = 1;
        #10 reset_n = 0;
        #10 reset_n = 1;

        // Test case 1: Simple shift
        data_in = 1'b1;
        shift_enable = 1'b1;
        repeat (8) @(posedge clk);
        if (data_out !== 8'b01111111) $display("Error: Test case 1 failed. Expected: 01111111, Received: %b", data_out);

        // Test case 2: Shift with alternating bits
        data_in = 1'b0;
        @(posedge clk);
        data_in = 1'b1;
        @(posedge clk);
        data_in = 1'b0;
        @(posedge clk);
        data_in = 1'b1;
        @(posedge clk);
        data_in = 1'b0;
        @(posedge clk);
        data_in = 1'b1;
        @(posedge clk);
        data_in = 1'b0;
        @(posedge clk);
        data_in = 1'b1;
        @(posedge clk);
        if (data_out !== 8'b01010101) $display("Error: Test case 2 failed. Expected: 01010101, Received: %b", data_out);

        // Test case 3: Shift without shift_enable
        data_in = 1'b0;
        shift_enable = 1'b0;
        @(posedge clk);
        if (data_out !== 8'b01010101) $display("Error: Test case 3 failed. Expected: 01010101, Received: %b", data_out);

        // Test case 4: Reset during shift operation
        data_in = 1'b1;
        shift_enable = 1'b1;
        @(posedge clk);
        reset_n = 0;
        @(posedge clk);
        reset_n = 1;
        if (data_out !== 8'b00000000) $display("Error: Test case 4 failed. Expected: 00000000, Received: %b", data_out);

        // Display success message and end simulation
        $display("All test cases passed!");
        $finish;
    end

endmodule
