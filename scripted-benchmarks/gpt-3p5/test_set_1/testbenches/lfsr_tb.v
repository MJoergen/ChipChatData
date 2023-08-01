module lfsr_tb;
  reg clk;
  reg rst_n;
  wire [7:0] data;

  lfsr uut (
    .clk(clk),
    .rst_n(rst_n),
    .data(data)
  );

  always #5 clk = ~clk;

  initial begin
    clk = 0;
    #10;
    rst_n = 0;
    #10;
    rst_n = 1;
    #20;
    if (data !== 8'b10001010) begin
      $display("Testcase 1 failed! Expected 8'b10001010, got %b", data);
      $finish;
    end
    else begin
      $display("Testcase 1 passed.");
    end

    integer i;
    integer expected_seq[256];
    expected_seq[0] = 8'h10;
    for (i = 1; i < 256; i = i + 1) begin
      expected_seq[i] = (expected_seq[i - 1] << 1) ^ ((expected_seq[i - 1][7] ^ expected_seq[i - 1][4] ^ expected_seq[i - 1][2] ^ expected_seq[i - 1][1]) ? 8'h1B : 0);
    end

    for (i = 0; i < 256; i = i + 1) begin
      #5;
      if (data !== expected_seq[i]) begin
        $display("Testcase 2 failed at cycle %d! Expected %b, got %b", i, expected_seq[i], data);
        $finish;
      end
    end
    $display("Testcase 2 passed.");
    $finish;
  end

  initial begin
    #1280;
    $finish;
  end
endmodule

