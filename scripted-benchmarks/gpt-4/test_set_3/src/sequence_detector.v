module sequence_detector(
    input clk,
    input reset_n,
    input [2:0] data,
    output reg sequence_found
);

reg [2:0] state;

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        state <= 3'b000;
        sequence_found <= 1'b0;
    end else begin
        // Reset sequence_found at each clock cycle
        sequence_found <= 1'b0;

        case (state)
            3'b000: begin
                if (data == 3'b001) begin
                    state <= 3'b001;
                end
            end
            3'b001: begin
                if (data == 3'b101) begin
                    state <= 3'b010;
                end else if (data != 3'b001) begin
                    state <= 3'b000;
                end
            end
            3'b010: begin
                if (data == 3'b110) begin
                    state <= 3'b011;
                end else if (data != 3'b101) begin
                    state <= 3'b000;
                end
            end
            3'b011: begin
                if (data == 3'b000) begin
                    state <= 3'b100;
                end else if (data != 3'b110) begin
                    state <= 3'b000;
                end
            end
            3'b100: begin
                if (data == 3'b110) begin
                    state <= 3'b101;
                end else if (data != 3'b000) begin
                    state <= 3'b000;
                end
            end
            3'b101: begin
                if (data == 3'b110) begin
                    state <= 3'b110;
                end else if (data != 3'b110) begin
                    state <= 3'b000;
                end
            end
            3'b110: begin
                if (data == 3'b011) begin
                    state <= 3'b111;
                end else if (data != 3'b110) begin
                    state <= 3'b000;
                end
            end
            3'b111: begin
                if (data == 3'b101) begin
                    state <= 3'b000;
                    sequence_found <= 1'b1;
                end else begin
                    state <= 3'b000;
                end
            end
        endcase
    end
end

endmodule

