module shift_register (
    input wire clk,
    input wire reset_n,
    input wire data_in,
    input wire shift_enable,
    output reg [7:0] data_out
);

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        data_out <= 8'b0; // Active-low reset: Clear the register when reset_n is low
    end else if (shift_enable) begin
        data_out <= {data_out[6:0], data_in}; // Shift the register and insert the new data bit
    end
end

endmodule
