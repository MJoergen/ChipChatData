module lfsr (
    input wire clk,
    input wire reset_n,
    output reg [7:0] data
);

// Declare the tap locations
localparam TAP1 = 1;
localparam TAP2 = 4;
localparam TAP3 = 6;
localparam TAP4 = 7;

// Declare an internal signal to hold the next state
reg [7:0] data_next;

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        // Active-low reset: initialize data to the given initial state
        data <= 8'b10001010;
    end else begin
        // Shift and apply XOR taps
        data_next[0] = data[TAP1 - 1] ^ data[TAP2 - 1] ^ data[TAP3 - 1] ^ data[TAP4 - 1];
        data_next[7:1] = data[6:0];
        data <= data_next;
    end
end

endmodule

