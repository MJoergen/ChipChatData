`timescale 1ns / 1ps

module traffic_light_tb;

    reg Clock;
    reg Reset_n;
    reg Enable;
    wire Red;
    wire Yellow;
    wire Green;

    // Instantiate the traffic_light module
    traffic_light tl (
        .Clock(Clock),
        .Reset_n(Reset_n),
        .Enable(Enable),
        .Red(Red),
        .Yellow(Yellow),
        .Green(Green)
    );

    // Clock generation
    always begin
        #5 Clock = ~Clock;
    end

    // Stimulus generation and checking
    integer fail_count;
    initial begin
        // Initialize signals
        Clock = 0;
        Reset_n = 0;
        Enable = 0;

        // Reset the traffic_light module
        #10 Reset_n = 1;
        #5 Enable = 1;

        // Initialize fail_count
        fail_count = 0;

        // Check RED state (32 clock cycles)
        for (integer i = 0; i < 32; i++) begin
            #10;
            if (i < 31 && (Red !== 1 || Yellow !== 0 || Green !== 0)) begin
                $display("[%0dns] ERROR: Expected RED, Observed: R=%b, Y=%b, G=%b", $time, Red, Yellow, Green);
                fail_count++;
            end else if (i == 31 && (Red !== 0 || Yellow !== 0 || Green !== 1)) begin
            $display("[%0dns] ERROR: Expected GREEN, Observed: R=%b, Y=%b, G=%b", $time, Red, Yellow, Green);
            fail_count++;
        end
    end

    // Check GREEN state (20 clock cycles)
    for (integer i = 0; i < 20; i++) begin
        #10;
        if (i < 19 && (Red !== 0 || Yellow !== 0 || Green !== 1)) begin
            $display("[%0dns] ERROR: Expected GREEN, Observed: R=%b, Y=%b, G=%b", $time, Red, Yellow, Green);
            fail_count++;
        end else if (i == 19 && (Red !== 0 || Yellow !== 1 || Green !== 0)) begin
            $display("[%0dns] ERROR: Expected YELLOW, Observed: R=%b, Y=%b, G=%b", $time, Red, Yellow, Green);
            fail_count++;
        end
    end

    // Check YELLOW state (7 clock cycles)
    for (integer i = 0; i < 7; i++) begin
        #10;
        if (i < 6 && (Red !== 0 || Yellow !== 1 || Green !== 0)) begin
            $display("[%0dns] ERROR: Expected YELLOW, Observed: R=%b, Y=%b, G=%b", $time, Red, Yellow, Green);
            fail_count++;
        end else if (i == 6 && (Red !== 1 || Yellow !== 0 || Green !== 0)) begin
            $display("[%0dns] ERROR: Expected RED, Observed: R=%b, Y=%b, G=%b", $time, Red, Yellow, Green);
            fail_count++;
        end
    end

    // Additional cycles to observe the behavior
    #100;

    // Report the test results
    if (fail_count == 0) begin
        $display("[%0dns] TEST PASSED!", $time);
    end else begin
        $display("[%0dns] TEST FAILED! %0d errors found.", $time, fail_count);
    end

    // Finish the simulation
    $finish;
end

endmodule
