`timescale 1ns/1ps

module traffic_light_tb();
    reg clk;
    reg reset_n;
    reg enable;
    wire red;
    wire yellow;
    wire green;

    // Instantiate the traffic_light module
    traffic_light uut (
        .clk(clk),
        .reset_n(reset_n),
        .enable(enable),
        .red(red),
        .yellow(yellow),
        .green(green)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;
    end

    // Stimulus generation and checking
    integer i;

    initial begin
        // Initialize signals
        clk = 0;
        reset_n = 0;
        enable = 0;

        // Reset the traffic_light module
        #10 reset_n = 1;
        #10 reset_n = 0;
        #10 reset_n = 1;

        // Enable the traffic_light module
        enable = 1;

        // Check if the traffic_light transitions correctly
        for (i = 0; i < 130; i++) begin
            @(posedge clk) begin
                // Check for Red state
                if (i % 59 == 0)
                    if (!(red && !yellow && !green)) $display("Error: Expected RED state at time: %t", $time);
                // Check for Green state
                else if (i % 59 == 32)
                    if (!(!red && !yellow && green)) $display("Error: Expected GREEN state at time: %t", $time);
                // Check for Yellow state
                else if (i % 59 == 52)
                    if (!(!red && yellow && !green)) $display("Error: Expected YELLOW state at time: %t", $time);
            end
        end

        // Disable the traffic_light module
        enable = 0;

        // Finish simulation
        #10 $finish;
    end

endmodule

