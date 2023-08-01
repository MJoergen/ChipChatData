`timescale 1ns/100ps

module tb_enabled_ring_oscillator();

    reg enable;
    wire oscillate;
    integer num_cycles;
    integer num_errors;

    // Instantiate the enabled_ring_oscillator module
    enabled_ring_oscillator dut (
        .enable(enable),
        .oscillate(oscillate)
    );

    // Clocking and checking task
    task check_oscillation;
        input [31:0] num_cycles;
        reg prev_oscillate;
        integer cycle_count;
        integer error_count;
        begin
            prev_oscillate = oscillate;
            cycle_count = 0;
            error_count = 0;
            repeat (num_cycles) begin
                #5; // Half-period delay
                if (enable && oscillate == prev_oscillate) begin
                    $display("Error at time %t: Oscillation not detected", $time);
                    error_count = error_count + 1;
                end
                prev_oscillate = oscillate;
                cycle_count = cycle_count + 1;
            end
            $display("Completed %0d cycles with %0d errors", cycle_count, error_count);
            num_errors = error_count;
        end
    endtask

    // Testbench stimulus
    initial begin
        // Test case 1: Enable = 0, oscillator should not oscillate
        enable = 0;
        num_errors = 0;
        $display("Test case 1: Enable = 0");
        #10; // Allow some propagation delay
        if (oscillate !== 0) begin
            $display("Error at time %t: Oscillator should not oscillate when enable = 0", $time);
            num_errors = num_errors + 1;
        end

        // Test case 2: Enable = 1, oscillator should oscillate
        enable = 1;
        $display("Test case 2: Enable = 1");
        #10; // Allow some propagation delay
        check_oscillation(20);
        num_errors = num_errors + num_errors;

        // Test case 3: Enable toggled, oscillator should follow enable signal
        enable = 0;
        $display("Test case 3: Enable toggled");
        #50;
        enable = 1;
        #10; // Allow some propagation delay
        check_oscillation(10);
        num_errors = num_errors + num_errors;

        // Final results
        if (num_errors == 0) begin
            $display("All test cases passed!");
        end else begin
            $display("Testbench failed with %0d errors", num_errors);
        end

        $finish;
    end

reg vcd_clk;
initial begin
    $dumpfile("my_design.vcd");
    $dumpvars(0, tb_enabled_ring_oscillator);
end

always #5 vcd_clk = ~vcd_clk; // Toggle clock every 5 time units


endmodule

