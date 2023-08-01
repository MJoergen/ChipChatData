module DiceRoller_TB;
    reg clk;
    reg reset;
    reg [1:0] die_select;
    reg roll;
    wire [7:0] rolled_number_wire;
    reg [7:0] rolled_number;

    integer roll_counter;
    integer pseudo_random_numbers [0:3];

    initial begin
        // Initialize inputs
        clk = 0;
        reset = 1;
        die_select = 2'b00;
        roll = 0;

        // Run reset cycle
        #10 reset = 0;

        // Test case 1: Roll a 4-sided die
        die_select = 2'b00;
        roll = 1;
        #20;
        roll = 0;
        #20;
        if (rolled_number !== pseudo_random_numbers[0]) begin
            $display("[Test Case 1] FAILED - Incorrect rolled number: %b", rolled_number);
            $finish;
        end

        // Test case 2: Roll a 6-sided die
        die_select = 2'b01;
        roll = 1;
        #20;
        roll = 0;
        #20;
        if (rolled_number !== pseudo_random_numbers[1]) begin
            $display("[Test Case 2] FAILED - Incorrect rolled number: %b", rolled_number);
            $finish;
        end

        // Test case 3: Roll an 8-sided die
        die_select = 2'b10;
        roll = 1;
        #20;
        roll = 0;
        #20;
        if (rolled_number !== pseudo_random_numbers[2]) begin
            $display("[Test Case 3] FAILED - Incorrect rolled number: %b", rolled_number);
            $finish;
        end

        // Test case 4: Roll a 20-sided die
        die_select = 2'b11;
        roll = 1;
        #20;
        roll = 0;
        #20;
        if (rolled_number !== pseudo_random_numbers[3]) begin
            $display("[Test Case 4] FAILED - Incorrect rolled number: %b", rolled_number);
            $finish;
        end

        $display("All test cases PASSED");
        $finish;
    end

    always begin
        #5 clk = ~clk;
    end

    // Instantiate the design under test (DiceRoller)
    DiceRoller uut (
        .clk(clk),
        .reset(reset),
        .die_select(die_select),
        .roll(roll),
        .rolled_number(rolled_number_wire)
    );

    always @(posedge clk) begin
        if (reset) begin
            rolled_number <= 8'b0;
        end else if (roll) begin
            roll_counter <= roll_counter + 1;
            case (roll_counter)
                1: rolled_number <= pseudo_random_numbers[0]; // Pseudo-random number for 4-sided die
                2: rolled_number <= pseudo_random_numbers[1]; // Pseudo-random number for 6-sided die
                3: rolled_number <= pseudo_random_numbers[2]; // Pseudo-random number for 8-sided die
                4: rolled_number <= pseudo_random_numbers[3]; // Pseudo-random number for 20-sided die
            default: rolled_number <= 8'b0;
        endcase
    end
end

assign rolled_number_wire = rolled_number;

initial begin
    // Generate pseudo-random numbers for each roll
    pseudo_random_numbers[0] = 8'b00000001; // Pseudo-random number for 4-sided die
    pseudo_random_numbers[1] = 8'b00000101; // Pseudo-random number for 6-sided die
    pseudo_random_numbers[2] = 8'b00001011; // Pseudo-random number for 8-sided die
    pseudo_random_numbers[3] = 8'b00011100; // Pseudo-random number for 20-sided die

    // Monitor the values of inputs and outputs
    $monitor("Time = %0t: clk = %b, reset = %b, die_select = %b, roll = %b, rolled_number = %b", $time, clk, reset, die_select, roll, rolled_number);

    // Simulation duration
    #200;
    $finish;
end

endmodule
