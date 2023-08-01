module SequenceGenerator_TB;
    reg clk;
    reg reset_n;
    reg enable;
    wire [7:0] data;

    integer i;
    reg [2:0] counter;

    initial begin
        // Initialize inputs
        clk = 0;
        reset_n = 1;
        enable = 0;
        counter = 0;

        // Generate clock
        forever begin
            #5 clk = ~clk;
        end
    end

    // Instantiate the design under test
    SequenceGenerator dut (
        .clk(clk),
        .reset_n(reset_n),
        .enable(enable),
        .data(data)
    );

    // Define expected sequence values
    reg [7:0] expected_sequence [0:7];

    // Initialize expected sequence values
    initial begin
        for (i = 0; i < 8; i = i + 1) begin
            case (i)
                0: expected_sequence[i] = 8'hAF;
                1: expected_sequence[i] = 8'hBC;
                2: expected_sequence[i] = 8'hE2;
                3: expected_sequence[i] = 8'h78;
                4: expected_sequence[i] = 8'hFF;
                5: expected_sequence[i] = 8'hE2;
                6: expected_sequence[i] = 8'h0B;
                 7: expected_sequence[i] = 8'h8D;
            endcase
        end
    end

    // Stimulus
    initial begin
        // Wait for a few cycles
        #10;

        // Assert reset
        reset_n = 0;
        #5;

        // Deassert reset
        reset_n = 1;

        // Enable the sequence generator
        enable = 1;

        // Verify the output sequence
        for (i = 0; i < 64; i = i + 1) begin
            #5;

            // Check output against expected value
            if (data !== expected_sequence[counter]) begin
                $display("Error: Expected data to be %h, but got %h at iteration %d", expected_sequence[counter], data, i);
                $finish;
            end

            counter = counter + 1;
            if (counter == 8)
                counter = 0;
        end

        // Disable the sequence generator
        enable = 0;

        // Wait for a few cycles
        #10;

        // Enable the sequence generator again
        enable = 1;

        // Verify the output sequence again
        for (i = 0; i < 64; i = i + 1) begin
            #5;

            // Check output against expected value
            if (data !== expected_sequence[counter]) begin
                $display("Error: Expected data to be %h, but got %h at iteration %d", expected_sequence[counter], data, i);
                $finish;
            end

            counter = counter + 1;
            if (counter == 8)
                counter = 0;
        end

        // Simulation completed successfully
        $display("Simulation completed successfully.");
        $finish;
    end
endmodule

