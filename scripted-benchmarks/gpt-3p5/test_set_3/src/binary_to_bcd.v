module BinaryToBCD(
  input [4:0] binary_input,
  output reg [7:0] bcd_output
);

  always @(*)
  begin
    case (binary_input)
      5'b00000: bcd_output = 8'b0000_0000; // BCD output for 0
      5'b00001: bcd_output = 8'b0000_0001; // BCD output for 1
      5'b00010: bcd_output = 8'b0000_0010; // BCD output for 2
      5'b00011: bcd_output = 8'b0000_0011; // BCD output for 3
      5'b00100: bcd_output = 8'b0000_0100; // BCD output for 4
      5'b00101: bcd_output = 8'b0000_0101; // BCD output for 5
      5'b00110: bcd_output = 8'b0000_0110; // BCD output for 6
      5'b00111: bcd_output = 8'b0000_0111; // BCD output for 7
      5'b01000: bcd_output = 8'b0000_1000; // BCD output for 8
      5'b01001: bcd_output = 8'b0000_1001; // BCD output for 9
      default: bcd_output = 8'bxxxx_xxxx; // Invalid input
    endcase
  end

endmodule

