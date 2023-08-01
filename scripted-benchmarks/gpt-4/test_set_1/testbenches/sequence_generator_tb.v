module tb_sequence_generator;
    reg clock = 0;
    reg reset_n;
    reg enable;
    wire [7:0] data;

    sequence_generator seq_gen (
        .clock(clock),
        .reset_n(reset_n),
        .enable(enable),
        .data(data)
    );

    integer i;
    integer j;

    reg [7:0] test_sequence [0:7];

    task check_output;
        input [7:0] expected_data;
        begin
            if (data !== expected_data) begin
                $display("Error: Expected data = 8'h%h, received data = 8'h%h at time %t ns", expected_data, data, $time);
                $finish;
            end
        end
    endtask

    always #5 clock = ~clock;

    initial begin
        // Initialize signals
        clock = 0;
        reset_n = 0;
        enable = 0;

        // Initialize test_sequence array
        test_sequence[0] = 8'hAF;
        test_sequence[1] = 8'hBC;
        test_sequence[2] = 8'hE2;
        test_sequence[3] = 8'h78;
        test_sequence[4] = 8'hFF;
        test_sequence[5] = 8'hE2;
        test_sequence[6] = 8'h0B;
        test_sequence[7] = 8'h8D;

        // Apply reset
        #10 reset_n = 1;
        #10 reset_n = 0;
        #10 reset_n = 1;

        // Test the sequence generator with enable signal
        for (i = 0; i < 16; i = i + 1) begin
            #1 enable = 1; // Add a small delay before changing the enable signal
            #9; // Wait for the rising edge of the clock before checking the output
            check_output(test_sequence[(i + 1) % 8]); // Check the output against the next index in the sequence
        end

        // Test the sequence generator without enable signal
        #1 enable = 0; // Add a small delay before changing the enable signal
        #9; // Wait for the rising edge of the clock before checking the output
        check_output(test_sequence[i % 8]); // Check the output when enable is low

        for (j = 0; j < 7; j = j + 1) begin
            #10; // Wait for the rising edge of the clock before checking the output
            check_output(test_sequence[i % 8]); // Output should remain the same
        end

        // Test the sequence generator after reset
        #10 reset_n = 0;
        #10 reset_n = 1;
        #5; // Wait for the rising edge of the clock before checking the output
        check_output(test_sequence[0]);

        $display("All test cases passed!");
        $finish;
    end
endmodule

