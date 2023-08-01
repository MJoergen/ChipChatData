module lfsr (
    input clk,
    input rst_n,
    output reg [7:0] data
);

reg [7:0] state = 8'b10001010;

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        state <= 8'b10001010;
        data <= 8'b10001010;
    end else begin
        state <= {state[6:0], state[1]^state[4]^state[6]^state[7]};
        data <= state;
    end
end

endmodule
