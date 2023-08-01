`timescale 1ns/1ns

module sequence_detector_tb;

reg clk, rst_n, enable;
reg [2:0] data;
wire seq_found;

sequence_detector dut (
    .clk(clk),
    .rst_n(rst_n),
    .data(data),
    .seq_found(seq_found)
);

initial begin
    clk = 0;
    rst_n = 1;
    enable = 0;
    data = 3'b000;

    #10 enable = 1;
    rst_n = 0;
    #10 rst_n = 1;

    // Test Case 1: Sequence found
    #10 data = 3'b001;
    #10 data = 3'b101;
    #10 data = 3'b110;
    #10 data = 3'b000;
    #10 data = 3'b110;
    #10 data = 3'b110;
    #10 data = 3'b011;
    #10 data = 3'b101;

    // Check that sequence is found
    #10 if (seq_found) begin
        $display("Test Case 1: Sequence found");
    end else begin
        $error("Test Case 1: Sequence not found");
    end

    // Reset sequence detector
    rst_n = 0;
    #10 rst_n = 1;

    // Test Case 2: Sequence not found
    #10 data = 3'b001;
    #10 data = 3'b101;
    #10 data = 3'b111;

    // Check that sequence is not found
    #10 if (!seq_found) begin
        $display("Test Case 2: Sequence not found");
    end else begin
        $error("Test Case 2: Sequence found");
    end

    // Reset sequence detector
    rst_n = 0;
    #10 rst_n = 1;

    // Test Case 3: Sequence found
    #10 data = 3'b001;
    #10 data = 3'b101;
    #10 data = 3'b110;
    #10 data = 3'b000;
    #10 data = 3'b110;
    #10 data = 3'b110;
    #10 data = 3'b011;
    #10 data = 3'b101;

    // Check that sequence is found
    #10 if (seq_found) begin
        $display("Test Case 3: Sequence found");
    end else begin
        $error("Test Case 3: Sequence not found");
    end

    // Reset sequence detector
    rst_n = 0;
    #10 rst_n = 1;

    // Test Case 4: Sequence not found
    #10 data = 3'b001;
    #10 data = 3'b101;
    #10 data = 3'b111;

    // Check that sequence is not found
    #10 if (!seq_found) begin
        $display("Test Case 4: Sequence not found");
    end else begin
        $error("Test Case 4: Sequence found");
    end

    // Reset sequence detector
    rst_n = 0;
    #10 rst_n = 1;

    // Wait for reset to complete
    #10 if (!seq_found) begin
        $display("Sequence reset");
    end else begin
        $error("Sequence not reset");
    end

    // End simulation
    #10 $finish;
end

always #5 clk = ~clk;

endmodule

