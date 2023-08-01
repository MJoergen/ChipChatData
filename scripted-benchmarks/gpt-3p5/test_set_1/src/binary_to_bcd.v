module bin2bcd (
  input [4:0] bin_in,
  output reg [7:0] bcd_out
);

  // Assign the BCD values based on the binary input
  always @* begin
    case (bin_in)
      5'b00000: bcd_out = 8'b00000001;
      5'b00001: bcd_out = 8'b00000010;
      5'b00010: bcd_out = 8'b00000100;
      5'b00011: bcd_out = 8'b00000110;
      5'b00100: bcd_out = 8'b00001000;
      5'b00101: bcd_out = 8'b00001100;
      5'b00110: bcd_out = 8'b00010000;
      5'b00111: bcd_out = 8'b00010110;
      5'b01000: bcd_out = 8'b00011000;
      5'b01001: bcd_out = 8'b00011110;
      5'b01010: bcd_out = 8'b00100000;
      5'b01011: bcd_out = 8'b00100110;
      5'b01100: bcd_out = 8'b00101000;
      5'b01101: bcd_out = 8'b00101110;
      5'b01110: bcd_out = 8'b00110000;
      5'b01111: bcd_out = 8'b00110110;
      5'b10000: bcd_out = 8'b00111000;
      5'b10001: bcd_out = 8'b00111110;
      default: bcd_out = 8'b00000000; // For invalid inputs
    endcase
  end

endmodule

