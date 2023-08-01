module tb_dice_roller();

reg clk;
reg rst_n;
reg [1:0] die_select;
reg roll;
wire [7:0] rolled_number;

integer i;
integer num_rolls;
integer errors;
integer first_roll;

// Instantiate the dice_roller module
dice_roller dice_roller_inst (
    .clk(clk),
    .rst_n(rst_n),
    .die_select(die_select),
    .roll(roll),
    .rolled_number(rolled_number)
);

// Clock generation
always begin
    #5 clk = ~clk;
end

// Testbench stimulus and checking
initial begin
    // Initialize signals
    clk = 0;
    rst_n = 0;
    die_select = 0;
    roll = 0;

    // Initialize local variables
    num_rolls = 10; // Number of rolls per die type
    errors = 0;
    first_roll = 1;

    // Reset the design
    #10 rst_n = 1;
    #10 roll = 1;

    // Test each die type
    for (integer die = 0; die < 4; die = die + 1) begin : die_loop
        die_select = die;
        // Roll the die multiple times
        for (i = 0; i < num_rolls; i = i + 1) begin
            // Wait for the roll to complete
            @(posedge clk);
            roll = 0;
            @(posedge clk);

            // Check the rolled_number output if it's not the first roll
            if (!first_roll) begin
                case (die_select)
                    2'b00: if (rolled_number < 1 || rolled_number > 4) begin
                        $display("Error: Die select: %b, Rolled number: %d is out of range [1, 4]", die_select, rolled_number);
                        errors = errors + 1;
                    end
                    2'b01: if (rolled_number < 1 || rolled_number > 6) begin
                        $display("Error: Die select: %b, Rolled number: %d is out of range [1, 6]", die_select, rolled_number);
                        errors = errors + 1;
                    end
                    2'b10: if (rolled_number < 1 || rolled_number > 8) begin
                        $display("Error: Die select: %b, Rolled number: %d is out of range [1, 8]", die_select, rolled_number);
                        errors = errors + 1;
                    end
                    2'b11: if (rolled_number < 1 || rolled_number > 20) begin
                        $display("Error: Die select: %b, Rolled number: %d is out of range [1, 20]", die_select, rolled_number);
                        errors = errors + 1;
                    end
                endcase
            end
            first_roll = 0;

            // Trigger the next roll
            @(posedge clk);
            roll = 1;
        end
        // Reset roll signal after the last roll
        roll = 0;
        first_roll = 1;
    end

    // Display test results
    if (errors == 0) begin
		$display("All tests passed!");
	end
	else begin
		$display("Tests failed: %d errors", errors);
	end

// Finish the simulation
$finish;

end
reg vcd_clk;
initial begin
    $dumpfile("my_design.vcd");
    $dumpvars(0, tb_dice_roller);
end

always #5 vcd_clk = ~vcd_clk; // Toggle clock every 5 time units

endmodule
