module dice_roller (
    input clk,
    input rst_n,
    input [1:0] die_select,
    input roll,
    output reg [7:0] rolled_number
);

reg [7:0] rnd;

// Random number generator
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        rnd <= 8'h42;
        rolled_number <= 8'h1; // Assign initial value during reset
    end else begin
        rnd <= rnd * 8'h3f + 8'h29;
    end
end

// Roll logic
always @(posedge clk) begin
    if (roll) begin
        case (die_select)
            2'b00: rolled_number <= (rnd % 4) + 1;
            2'b01: rolled_number <= (rnd % 6) + 1;
            2'b10: rolled_number <= (rnd % 8) + 1;
            2'b11: rolled_number <= (rnd % 20) + 1;
        endcase
    end
end

endmodule

