module dice_roller_tb;

    reg clk;
    reg reset_n;
    reg [1:0] die_select;
    reg roll;

    wire [7:0] rolled_number;

    integer num_tests_passed;
    integer num_tests_failed;

    initial begin
        // Initialize inputs
        clk = 0;
        reset_n = 0;
        die_select = 0;
        roll = 0;

        // Reset the design
        reset_n = 1;
        #5 reset_n = 0;
        #100 reset_n = 1;

        // Test case 1: Roll a 4-sided die
        die_select = 0;
        roll = 1;
        #10 roll = 0;
        #200000;
        if (rolled_number != 1'b0 && rolled_number <= 4) begin
            $display("Test case 1 passed!");
            num_tests_passed++;
        end
        else begin
            $display("ERROR: Test case 1 failed!");
            num_tests_failed++;
        end

        // Test case 2: Roll a 6-sided die
        die_select = 1;
        roll = 1;
        #10 roll = 0;
        #200000;
        if (rolled_number != 1'b0 && rolled_number <= 6) begin
            $display("Test case 2 passed!");
            num_tests_passed++;
        end
        else begin
            $display("ERROR: Test case 2 failed!");
            num_tests_failed++;
        end

        // Test case 3: Roll an 8-sided die
        die_select = 2;
        roll = 1;
        #10 roll = 0;
        #200000;
        if (rolled_number != 1'b0 && rolled_number <= 8) begin
            $display("Test case 3 passed!");
            num_tests_passed++;
        end
        else begin
            $display("ERROR: Test case 3 failed!");
            num_tests_failed++;
        end

        // Test case 4: Roll a 20-sided die
        die_select = 3;
        roll = 1;
        #10 roll = 0;
        #200000;
        if (rolled_number != 1'b0 && rolled_number <= 20) begin
            $display("Test case 4 passed!");
            num_tests_passed++;
        end
        else begin
            $display("ERROR: Test case 4 failed!");
            num_tests_failed++;
        end

        // Print summary of test results
        $display("Tests passed: %0d", num_tests_passed);
        $display("Tests failed: %0d", num_tests_failed);

        // Terminate the simulation
        $finish;
    end

    // Toggle the clock
    always #5 clk = ~clk;

    // Instantiate the design under test
    dice_roller dut (
        .clk(clk),
        .reset_n(reset_n),
        .die_select(die_select),
        .roll(roll),
        .rolled_number(rolled_number)
    );
reg vcd_clk;
initial begin
    $dumpfile("my_design.vcd");
    $dumpvars(0, dice_roller_tb);
end

always #5 vcd_clk = ~vcd_clk; // Toggle clock every 5 time units

endmodule

