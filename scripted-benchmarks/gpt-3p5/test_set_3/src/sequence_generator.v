module SequenceGenerator (
    input wire clk,
    input wire reset_n,
    input wire enable,
    output reg [7:0] data
);

    reg [2:0] counter;
    reg [7:0] sequence [0:7];
    reg reset_sync;

    // Define the sequence
    initial begin
        sequence[0] = 8'b10101111;  // 0xAF
        sequence[1] = 8'b10111100;  // 0xBC
        sequence[2] = 8'b11100010;  // 0xE2
        sequence[3] = 8'b01111000;  // 0x78
        sequence[4] = 8'b11111111;  // 0xFF
        sequence[5] = 8'b11100010;  // 0xE2
        sequence[6] = 8'b00001011;  // 0x0B
        sequence[7] = 8'b10001101;  // 0x8D
    end

    always @(posedge clk) begin
        if (reset_sync) begin
            counter <= 0;
            data <= 8'b0;
        end
        else if (enable) begin
            counter <= counter + 1;
            data <= sequence[counter];
        end
    end

    always @(posedge clk or negedge reset_n) begin
        if (reset_n == 1'b0)
            reset_sync <= 1'b1;
        else if (reset_n == 1'b1)
            reset_sync <= 1'b0;
    end

endmodule

