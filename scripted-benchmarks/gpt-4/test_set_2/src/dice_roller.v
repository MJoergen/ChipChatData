module dice_roller (
    input wire clk,
    input wire rst_n,
    input wire [1:0] die_select,
    input wire roll,
    output reg [7:0] rolled_number
);

reg [31:0] lfsr;
reg roll_triggered;

// LFSR-based RNG
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        lfsr <= 32'hDEADBEEF; // Initial seed
    end else begin
        if (roll && !roll_triggered) begin
            lfsr <= {lfsr[30:0], lfsr[31] ^ lfsr[30]}; // 32-bit LFSR with maximal length
        end
    end
end

// Detect rising edge of the roll input
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        roll_triggered <= 1'b0;
    end else begin
        roll_triggered <= roll;
    end
end

// Dice roll logic
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        rolled_number <= 8'h00;
    end else begin
        if (roll && !roll_triggered) begin
            case (die_select)
                2'b00: rolled_number <= (lfsr[2:0] % 4) + 1;
                2'b01: rolled_number <= (lfsr[2:0] % 6) + 1;
                2'b10: rolled_number <= (lfsr[2:0] % 8) + 1;
                2'b11: rolled_number <= (lfsr[4:0] % 20) + 1;
                default: rolled_number <= 8'h00;
            endcase
        end
    end
end

endmodule

