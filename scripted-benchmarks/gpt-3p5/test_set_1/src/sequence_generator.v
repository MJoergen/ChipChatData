module sequence_generator(
    input clk,
    input rst_n,
    input en,
    output reg [7:0] data
);

    reg [2:0] state = 3'b000; // Initialize state to first state of sequence
    reg [7:0] SEQ_VALUES [0:7] = '{8'hAF, 8'hBC, 8'hE2, 8'h78, 8'hFF, 8'hE2, 8'h0B, 8'h8D}; // Use concatenation operator to initialize SEQ_VALUES array

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= 3'b000;
            data <= 8'b0;
        end
        else begin
            case (state)
                3'b000: begin
                    if (en) begin
                        state <= 3'b001;
                        data <= SEQ_VALUES[0];
                    end
                end
                3'b001: begin
                    if (en) begin
                        state <= 3'b010;
                        data <= SEQ_VALUES[1];
                    end
                end
                3'b010: begin
                    if (en) begin
                        state <= 3'b011;
                        data <= SEQ_VALUES[2];
                    end
                end
                3'b011: begin
                    if (en) begin
                        state <= 3'b100;
                        data <= SEQ_VALUES[3];
                    end
                end
                3'b100: begin
                    if (en) begin
                        state <= 3'b101;
                        data <= SEQ_VALUES[4];
                    end
                end
                3'b101: begin
                    if (en) begin
                        state <= 3'b110;
                        data <= SEQ_VALUES[5];
                    end
                end
                3'b110: begin
                    if (en) begin
                        state <= 3'b111;
                        data <= SEQ_VALUES[6];
                    end
                end
                3'b111: begin
                    if (en) begin
                        state <= 3'b000;
                        data <= SEQ_VALUES[7];
                    end
                end
                default: begin
                    state <= 3'b000;
                    data <= 8'b0;
                end
            endcase
        end
    end

endmodule

