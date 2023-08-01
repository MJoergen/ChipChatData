module sequence_generator_tb;

    // Define testbench inputs and outputs
    reg clk;
    reg rst_n;
    reg en;
    wire [7:0] data;

    // Instantiate sequence_generator module
    sequence_generator seq_gen(
        .clk(clk),
        .rst_n(rst_n),
        .en(en),
        .data(data)
    );

    // Define clock period parameter
    parameter CLK_PERIOD = 10;

    // Generate clock signal
    always #CLK_PERIOD clk = ~clk;

    // Reset the module at the beginning of the simulation
    initial begin
        rst_n = 0;
        en = 0;
        #CLK_PERIOD rst_n = 1;
    end

    // Test sequence generator with enable signal high
    task test_enable_high;
        integer i;
        begin
            en = 1;

            // Check for correct sequence output
            repeat(2) begin
                for (i = 0; i < 8; i = i + 1) begin
                    #CLK_PERIOD;
                    if (data !== seq_gen.SEQ_VALUES[i]) begin
                        $display("Error: unexpected sequence value %h at index %d", data, i);
                        $finish;
                    end
                end
            end

            $display("Test Passed: Sequence generator output matches expected sequence with enable signal high");
            $finish;
        end
    endtask

    // Test sequence generator with enable signal low
    task test_enable_low;
        integer i;
        begin
            en = 0;

            // Check for zero output when enable signal is low
            repeat(2) begin
                #CLK_PERIOD;
                if (data !== 0) begin
                    $display("Error: non-zero data output when enable signal is low");
                    $finish;
                end
            end

            $display("Test Passed: Sequence generator output is zero with enable signal low");
            $finish;
        end
    endtask

    // Run tests
    initial begin
        #CLK_PERIOD;
        test_enable_high();
        #CLK_PERIOD;
        test_enable_low();
        #CLK_PERIOD;
        $finish;
    end

endmodule

