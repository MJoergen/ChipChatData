module DiceRoller (
    input wire clk,
    input wire reset,
    input wire [1:0] die_select,
    input wire roll,
    output reg [7:0] rolled_number
);

    // Internal state variables
    reg [7:0] random_number;
    reg [3:0] roll_count;

    // Roll count for each die type
    parameter ROLL_COUNT_4_SIDED = 2;
    parameter ROLL_COUNT_6_SIDED = 3;
    parameter ROLL_COUNT_8_SIDED = 4;
    parameter ROLL_COUNT_20_SIDED = 5;

    always @(posedge clk or negedge reset) begin
        if (!reset) begin
            // Reset state
            random_number <= 8'b0;
            roll_count <= 4'b0;
            rolled_number <= 8'b0;
        end else begin
            // Handle roll input
            if (roll) begin
                case (die_select)
                    2'b00: roll_count <= ROLL_COUNT_4_SIDED;
                    2'b01: roll_count <= ROLL_COUNT_6_SIDED;
                    2'b10: roll_count <= ROLL_COUNT_8_SIDED;
                    2'b11: roll_count <= ROLL_COUNT_20_SIDED;
                    default: roll_count <= 4'b0;
                endcase
            end

            // Generate random number
            if (roll_count > 0) begin
                random_number <= $random;
                roll_count <= roll_count - 1;
            end

            // Assign output
            if (roll_count == 0)
                rolled_number <= random_number;
            else
                rolled_number <= 8'b0;
        end
    end

endmodule

