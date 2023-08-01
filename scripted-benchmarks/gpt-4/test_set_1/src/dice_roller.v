module dice_roller (
    input wire clk,
    input wire reset_n,
    input wire [1:0] die_select,
    input wire roll,
    output reg [7:0] rolled_number
);

// Define LFSR's width and tap positions
localparam LFSR_WIDTH = 8;
localparam [LFSR_WIDTH-1:0] LFSR_TAPS = 8'b10011010;

reg [LFSR_WIDTH-1:0] lfsr_state;
wire lfsr_next_state = ^{lfsr_state[LFSR_WIDTH-1], lfsr_state & LFSR_TAPS};
reg roll_done;

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        lfsr_state <= 8'h1;
        rolled_number <= 8'h0;
        roll_done <= 1'b0;
    end else begin
        lfsr_state <= lfsr_next_state;
        if (roll && !roll_done) begin
            roll_done <= 1'b1;
            case (die_select)
                2'b00: rolled_number <= (lfsr_state % 4) + 1; // 4-sided die
                2'b01: rolled_number <= (lfsr_state % 6) + 1; // 6-sided die
                2'b10: rolled_number <= (lfsr_state % 8) + 1; // 8-sided die
                2'b11: rolled_number <= (lfsr_state % 20) + 1; // 20-sided die
                default: rolled_number <= 8'h0;
            endcase
        end else if (!roll) begin
            roll_done <= 1'b0;
        end
    end
end

endmodule

