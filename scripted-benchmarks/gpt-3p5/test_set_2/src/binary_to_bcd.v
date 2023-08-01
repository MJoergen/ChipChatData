module BinaryToBCD (
  input [4:0] binary_input,
  output reg [7:0] bcd_output
);

  always @* begin
    // Tens place conversion
    case (binary_input)
      5'b00000: bcd_output[7:4] = 4'b0000;
      5'b00001: bcd_output[7:4] = 4'b0000;
      5'b00010: bcd_output[7:4] = 4'b0000;
      5'b00011: bcd_output[7:4] = 4'b0000;
      5'b00100: bcd_output[7:4] = 4'b0000;
      5'b00101: bcd_output[7:4] = 4'b0000;
      5'b00110: bcd_output[7:4] = 4'b0000;
      5'b00111: bcd_output[7:4] = 4'b0000;
      5'b01000: bcd_output[7:4] = 4'b0000;
      5'b01001: bcd_output[7:4] = 4'b0001;
      5'b01010: bcd_output[7:4] = 4'b0001;
      5'b01011: bcd_output[7:4] = 4'b0001;
      5'b01100: bcd_output[7:4] = 4'b0001;
      5'b01101: bcd_output[7:4] = 4'b0001;
      5'b01110: bcd_output[7:4] = 4'b0001;
      5'b01111: bcd_output[7:4] = 4'b0001;
      5'b10000: bcd_output[7:4] = 4'b0001;
      5'b10001: bcd_output[7:4] = 4'b0001;
      5'b10010: bcd_output[7:4] = 4'b0010;
      5'b10011: bcd_output[7:4] = 4'b0010;
      5'b10100: bcd_output[7:4] = 4'b0010;
      5'b10101: bcd_output[7:4] = 4'b0010;
      5'b10110: bcd_output[7:4] = 4'b0010;
      5'b10111: bcd_output[7:4] = 4'b0010;
      5'b11000: bcd_output[7:4] = 4'b0010;
      5'b11001: bcd_output[7:4] = 4'b0010;
      default: bcd_output[7:4] = 4'b0000; // Reset to zero for invalid input
    endcase

    // Ones place conversion
    case (binary_input % 10)
      4'b0000: bcd_output[3:0] = 4'b0000;
      4'b0001: bcd_output[3:0] = 4'b0001;
      4'b0010: bcd_output[3:0] = 4'b0010;
      4'b0011: bcd_output[3:0] = 4'b0011;
      4'b0100: bcd_output[3:0] = 4'b0100;
      4'b0101: bcd_output[3:0] = 4'b0101;
      4'b0110: bcd_output[3:0] = 4'b0110;
      4'b0111: bcd_output[3:0] = 4'b0111;
      4'b1000: bcd_output[3:0] = 4'b1000;
      4'b1001: bcd_output[3:0] = 4'b1001;
      default: bcd_output[3:0] = 4'b0000; // Reset to zero for invalid input
    endcase
  end

endmodule

