module sequence_detector (
    input wire clk,
    input wire reset_n,
    input wire [2:0] data,
    output reg sequence_found
);

    reg [3:0] state, next_state;

    // State encoding
    localparam S0 = 4'b0000,
               S1 = 4'b0001,
               S2 = 4'b0010,
               S3 = 4'b0011,
               S4 = 4'b0100,
               S5 = 4'b0101,
               S6 = 4'b0110,
               S7 = 4'b0111;

    // Next state logic
    always @(*) begin
        next_state = state;
        case (state)
            S0: if (data == 3'b001) next_state = S1;
            S1: if (data == 3'b101) next_state = S2;
            S2: if (data == 3'b110) next_state = S3;
            S3: if (data == 3'b000) next_state = S4;
            S4: if (data == 3'b110) next_state = S5;
            S5: if (data == 3'b110) next_state = S6;
            S6: if (data == 3'b011) next_state = S0;
                 else if (data == 3'b101) next_state = S7;
            S7: if (data == 3'b101) next_state = S2;
                 else if (data == 3'b001) next_state = S1;
                 else if (data == 3'b110) next_state = S3;
        endcase
    end

    // State register and sequence_found output
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            state <= S0;
            sequence_found <= 1'b0;
        end else begin
            state <= next_state;
            sequence_found <= (state == S6 && data == 3'b011) || (state == S7 && data == 3'b101 && next_state == S2);
        end
    end

endmodule

