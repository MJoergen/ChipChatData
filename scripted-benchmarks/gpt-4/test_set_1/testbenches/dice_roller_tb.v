`timescale 1ns / 1ps

module tb_dice_roller;
    reg clk;
    reg reset_n;
    reg [1:0] die_select;
    reg roll;
    wire [7:0] rolled_number;

    // Instantiate the dice_roller module
    dice_roller uut (
        .clk(clk),
        .reset_n(reset_n),
        .die_select(die_select),
        .roll(roll),
        .rolled_number(rolled_number)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;
    end

    // Testbench stimulus and checking
    integer i;
    integer num_tests = 100;
    integer fail_count = 0;

    initial begin
        // Initialize signals
        clk = 0;
        reset_n = 0;
        die_select = 0;
        roll = 0;
        #10 reset_n = 1;

        // Test cases
        for (i = 0; i < num_tests; i++) begin
            // Randomize die_select
            die_select = $random % 4;

            // Wait for the next rising edge of the clock
            @(posedge clk);

            // Set roll to high
            roll = 1;
		// Wait for the next rising edge of the clock
        @(posedge clk);

        // Set roll to low
        roll = 0;

        // Wait for the next rising edge of the clock
        @(posedge clk);

        // Check the output
        case (die_select)
            2'b00: // 4-sided die
                if (rolled_number == 0 || rolled_number > 4) begin
                    $display("Test %0d failed: 4-sided die - rolled_number = %0d", i, rolled_number);
                    fail_count = fail_count + 1;
                end
            2'b01: // 6-sided die
                if (rolled_number == 0 || rolled_number > 6) begin
                    $display("Test %0d failed: 6-sided die - rolled_number = %0d", i, rolled_number);
                    fail_count = fail_count + 1;
                end
            2'b10: // 8-sided die
                if (rolled_number == 0 || rolled_number > 8) begin
                    $display("Test %0d failed: 8-sided die - rolled_number = %0d", i, rolled_number);
                    fail_count = fail_count + 1;
                end
            2'b11: // 20-sided die
                if (rolled_number == 0 || rolled_number > 20) begin
                    $display("Test %0d failed: 20-sided die - rolled_number = %0d", i, rolled_number);
                    fail_count = fail_count + 1;
                end
        endcase
    end

    // Report test results
    $display("%0d out of %0d tests failed.", fail_count, num_tests);
    if (fail_count == 0) begin
        $display("All tests passed!");
    end

    // Finish the simulation
    $finish;
end

reg vcd_clk;
initial begin
	vcd_clk = 0;
	$dumpfile("dice_roller.vcd");
	$dumpvars(0, tb_dice_roller);
	while (1) begin
		#5 vcd_clk = ~vcd_clk;
	end
end

endmodule
