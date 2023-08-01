module shift_register (
    input wire clk,
    input wire reset_n,
    input wire data_in,
    input wire shift_enable,
    output reg [7:0] data_out
);

always @(posedge clk or negedge reset_n) begin
    if (~reset_n) begin
        // Active-low reset
        data_out <= 8'b0;
    end else if (shift_enable) begin
        // Shift data if shift_enable is asserted
        data_out <= {data_out[6:0], data_in};
    end
end

endmodule

