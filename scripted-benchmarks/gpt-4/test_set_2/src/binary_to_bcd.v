module binary_to_bcd_converter(
    input wire [4:0] binary_input,
    output wire [7:0] bcd_output
);

reg [7:0] bcd;
reg [4:0] binary_temp;
integer i;

always @ (binary_input) begin
    bcd = 8'b0;
    binary_temp = binary_input;

    for (i = 0; i < 5; i++) begin
        if (bcd[3:0] >= 5)
            bcd[3:0] = bcd[3:0] + 3;
        if (bcd[7:4] >= 5)
            bcd[7:4] = bcd[7:4] + 3;

        bcd = bcd << 1;
        bcd[0] = binary_temp[4];
        binary_temp = binary_temp << 1;
    end
end

assign bcd_output = bcd;

endmodule

