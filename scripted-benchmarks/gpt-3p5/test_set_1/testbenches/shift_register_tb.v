`timescale 1ns/1ps

module shift_register_tb;

    // Define module inputs and outputs
    reg clk;
    reg reset_n;
    reg data;
    reg shift_enable;
    wire [7:0] q;

    // Instantiate shift register design
    shift_register dut (
        .clk(clk),
        .reset_n(reset_n),
        .data(data),
        .shift_enable(shift_enable),
        .q(q)
    );

    // Generate clock signal
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Define test cases
    initial begin
        // Test case 1: reset the shift register
        reset_n = 0;
        data = 1'b0;
        shift_enable = 0;
        #10 reset_n = 1'b0;
        #10 reset_n = 1'b1;
        #10 $display("Test case 1: q = %b", q);

        // Test case 2: shift in one bit of data
        reset_n = 1'b1;
        data = 1'b1;
        shift_enable = 1'b1;
        #10 shift_enable = 1'b0;
        #10 $display("Test case 2: q = %b", q);

        // Test case 3: shift in another bit of data
        data = 1'b0;
        shift_enable = 1'b1;
        #10 shift_enable = 1'b0;
        #10 $display("Test case 3: q = %b", q);

        // Test case 4: shift in all 8 bits of data
        data = 1'b1;
        shift_enable = 1'b1;
        #10 shift_enable = 1'b1;
        data = 1'b0;
        #10 shift_enable = 1'b1;
        data = 1'b0;
        #10 shift_enable = 1'b1;
        data = 1'b0;
        #10 shift_enable = 1'b1;
        data = 1'b0;
        #10 shift_enable = 1'b1;
        data = 1'b0;
        #10 shift_enable = 1'b1;
        data = 1'b0;
        #10 shift_enable = 1'b1;
        data = 1'b1;
        #10 shift_enable = 1'b0;
        #10 $display("Test case 4: q = %b", q);

        // Test case 5: reset the shift register again
        reset_n = 0;
        data = 1'b1;
        shift_enable = 0;
        #10 reset_n = 1'b0;
        #10 reset_n = 1'b1;
        #10 $display("Test case 5: q = %b", q);

    // End simulation
    $finish;
end

endmodule
