module shift_register(
    input clk,
    input reset_n,
    input data,
    input shift_enable,
    output reg [7:0] q
);

always @(posedge clk, negedge reset_n) begin
    if (!reset_n) begin
        q <= 8'b0;
    end else if (shift_enable) begin
        q <= {q[6:0], data};
    end
end

endmodule

