module sequence_detector(
    input clk,
    input rst_n,
    input [2:0] data,
    output reg seq_found
);

parameter IDLE = 3'b000;
parameter S1 = 3'b001;
parameter S2 = 3'b010;
parameter S3 = 3'b011;
parameter S4 = 3'b100;
parameter S5 = 3'b101;
parameter S6 = 3'b110;
parameter S7 = 3'b111;

reg [2:0] state_reg;
initial state_reg = IDLE;
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        state_reg <= IDLE;
    end else begin
        state_reg <= next_state;
    end
end

reg [2:0] next_state;
always @(*) begin
    case (state_reg)
        IDLE: begin
            if (data == 3'b001) begin
                next_state = S1;
            end else begin
                next_state = IDLE;
            end
        end
        S1: begin
            if (data == 3'b101) begin
                next_state = S2;
            end else begin
                next_state = IDLE;
            end
        end
        S2: begin
            if (data == 3'b110) begin
                next_state = S3;
            end else begin
                next_state = IDLE;
            end
        end
        S3: begin
            if (data == 3'b000) begin
                next_state = S4;
            end else begin
                next_state = IDLE;
            end
        end
        S4: begin
            if (data == 3'b110) begin
                next_state = S5;
            end else begin
                next_state = IDLE;
            end
        end
        S5: begin
            if (data == 3'b110) begin
                next_state = S6;
            end else begin
                next_state = IDLE;
            end
        end
        S6: begin
            if (data == 3'b011) begin
                next_state = S7;
            end else begin
                next_state = IDLE;
            end
        end
        S7: begin
            if (data == 3'b101) begin
                next_state = IDLE;
                seq_found = 1;
            end else begin
                next_state = IDLE;
            end
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

endmodule

