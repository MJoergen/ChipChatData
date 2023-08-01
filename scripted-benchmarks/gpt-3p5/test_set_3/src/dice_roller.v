module DiceRoller (
  input wire clk,
  input wire reset_n,
  input wire [1:0] die_select,
  input wire roll,
  output reg [7:0] rolled_number
);

  // Internal registers
  reg [7:0] four_sided_roll;
  reg [7:0] six_sided_roll;
  reg [7:0] eight_sided_roll;
  reg [7:0] twenty_sided_roll;

  // Random number generators for each die
  always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
      four_sided_roll <= 0;
      six_sided_roll <= 0;
      eight_sided_roll <= 0;
      twenty_sided_roll <= 0;
    end else begin
      if (roll) begin
        case (die_select)
          2'b00: four_sided_roll <= $random % 4;
          2'b01: six_sided_roll <= $random % 6;
          2'b10: eight_sided_roll <= $random % 8;
          2'b11: twenty_sided_roll <= $random % 20;
        endcase
      end
    end
  end

  // Output the rolled number based on the selected die
  always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
      rolled_number <= 0;
    end else begin
      case (die_select)
        2'b00: rolled_number <= four_sided_roll;
        2'b01: rolled_number <= six_sided_roll;
        2'b10: rolled_number <= eight_sided_roll;
        2'b11: rolled_number <= twenty_sided_roll;
      endcase
    end
  end

endmodule

