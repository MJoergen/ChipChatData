module bin2bcd_tb;

  // Parameters
  parameter CLK_PERIOD = 10;

  // Inputs
  reg [4:0] bin_in;
  // Outputs
  wire [7:0] bcd_out;

  // Instantiate the design under test
  bin2bcd dut (
    .bin_in(bin_in),
    .bcd_out(bcd_out)
  );

  // Additional signal to capture the output
  wire [7:0] bcd_out_tb;

  // Clock generation
  reg clk = 0;
  always #((CLK_PERIOD/2) * 1) clk = ~clk;

  // Test cases
  initial begin
    $display("Starting testbench...");
    $display("--------------------");
    // Test valid inputs
    bin_in = 5'b00000; #((CLK_PERIOD*1) * 1);
    #((CLK_PERIOD*1) * 1) $display("bin_in = %b, bcd_out = %b", bin_in, bcd_out_tb);
    bin_in = 5'b00001; #((CLK_PERIOD*1) * 1);
    #((CLK_PERIOD*1) * 1) $display("bin_in = %b, bcd_out = %b", bin_in, bcd_out_tb);
    bin_in = 5'b00110; #((CLK_PERIOD*1) * 1);
    #((CLK_PERIOD*1) * 1) $display("bin_in = %b, bcd_out = %b", bin_in, bcd_out_tb);
    bin_in = 5'b01111; #((CLK_PERIOD*1) * 1);
    #((CLK_PERIOD*1) * 1) $display("bin_in = %b, bcd_out = %b", bin_in, bcd_out_tb);
    bin_in = 5'b10000; #((CLK_PERIOD*1) * 1);
    #((CLK_PERIOD*1) * 1) $display("bin_in = %b, bcd_out = %b", bin_in, bcd_out_tb);
    // Test invalid inputs
    bin_in = 5'b11000; #((CLK_PERIOD*1) * 1);
    #((CLK_PERIOD*1) * 1) $display("bin_in = %b, bcd_out = %b (invalid)", bin_in, bcd_out_tb);
    bin_in = 5'b11111; #((CLK_PERIOD*1) * 1);
    #((CLK_PERIOD*1) * 1) $display("bin_in = %b, bcd_out = %b (invalid)", bin_in, bcd_out_tb);
    $display("--------------------");
    $display("Testbench finished.");
    $finish;
  end

  // Connect the additional signal to the output
  assign bcd_out_tb = bcd_out;

  // Stimulus
  always #((CLK_PERIOD*1) * 1) bin_in = $random;

endmodule

