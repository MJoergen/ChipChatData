module binary_to_bcd (
    input [4:0] binary_input,
    output reg [3:0] bcd_tens,
    output reg [3:0] bcd_units
);

integer i;
integer bcd_value;
integer binary_value;

always @(*) begin
    bcd_value = 0;
    binary_value = binary_input;

    // Double dabble algorithm to convert binary to BCD
    for (i = 0; i < 5; i = i + 1) begin
        // If the 4-bit BCD value is greater than or equal to 5, add 3
        if (bcd_value[3:0] >= 5) begin
            bcd_value = bcd_value + 3;
        end

        if (bcd_value[7:4] >= 5) begin
            bcd_value = bcd_value + (3 << 4);
        end

        // Shift the BCD value one bit to the left
        bcd_value = bcd_value << 1;

        // Add the next binary bit from the binary input
        bcd_value[0] = binary_value[4];

        // Shift the binary input one bit to the left
        binary_value = binary_value << 1;
    end

    bcd_tens = bcd_value[7:4];
    bcd_units = bcd_value[3:0];
end

endmodule

