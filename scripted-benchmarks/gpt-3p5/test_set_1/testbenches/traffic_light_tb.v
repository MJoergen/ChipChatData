`timescale 1ns/1ns

module traffic_light_tb;

    reg clk;
    reg reset_n;
    reg enable;

    wire red;
    wire yellow;
    wire green;

    // Add parameter for clock period
    parameter PERIOD = 20;

    // Instantiate the design under test
    traffic_light dut (
        .clk(clk),
        .reset_n(reset_n),
        .enable(enable),
        .red(red),
        .yellow(yellow),
        .green(green)
    );

    // Generate clock
    always begin
        #PERIOD/2;
        clk = ~clk;
    end

    // Initialize signals
    initial begin
        reset_n = 0;
        enable = 0;
        #PERIOD;

        reset_n = 1;
        #PERIOD;

        enable = 1;
        #32*PERIOD;

        enable = 0;
        #PERIOD;

        enable = 1;
        #20*PERIOD;

        enable = 0;
        #PERIOD;

        enable = 1;
        #7*PERIOD;

        $finish;
    end

    // Check outputs
    always @(posedge clk) begin
        if (red !== 1'b1) $display("ERROR: Expected red light");
        if (yellow !== 1'b0) $display("ERROR: Expected yellow light");
        if (green !== 1'b0) $display("ERROR: Expected green light");
    end

    initial
    begin
        $monitor("Time: %t  red: %b  yellow: %b  green: %b", $time, red, yellow, green);
    end

endmodule

