module lfsr (
    input wire clk,
    input wire reset_n, // Active-low reset
    output reg [7:0] data
);

// LFSR taps at locations 1, 4, 6, and 7
wire feedback = data[0] ^ data[3] ^ data[5] ^ data[6];

always @(posedge clk or negedge reset_n) begin
    if (~reset_n) begin
        // Active-low reset: Set initial state to 10001010
        data <= 8'b10001010;
    end else begin
        // Shift data left, and apply the feedback to the LSB after shifting
        data <= {data[6:0], feedback};
    end
end

endmodule

