module ShiftRegister (
  input wire clock,
  input wire reset_n,
  input wire data,
  input wire shift_enable,
  output wire [7:0] output_data
);

  reg [7:0] shift_register;

  always @(posedge clock or negedge reset_n) begin
    if (!reset_n)
      shift_register <= 8'b0;
    else if (shift_enable)
      shift_register <= {data, shift_register[7:1]};
  end

  assign output_data = shift_register;

endmodule

