module binary_to_bcd (
    input [4:0] binary_input,
    output reg [3:0] tens,
    output reg [3:0] ones
);

    integer temp;

    always @* begin
        temp = binary_input;
        tens = 0;
        ones = 0;

        for (integer i = 0; i < 5; i++) begin
            if (ones[3] || (ones[2:0] >= 5))
                ones = ones + 3;

            if (tens[3] || (tens[2:0] >= 5))
                tens = tens + 3;

            tens = tens << 1;
            tens[0] = ones[3];
            ones = ones << 1;
            ones[0] = temp[4];
            temp = temp << 1;
        end
    end

endmodule

