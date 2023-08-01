module sequence_generator (
    input wire clk,
    input wire reset_n, // Active-low reset
    input wire enable,
    output reg [7:0] data
);

reg [2:0] current_state, next_state;

// State transition and output logic
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        current_state <= 3'b000;
    end else begin
        current_state <= next_state;
    end
end

// State register
always @(*) begin
    case (current_state)
        3'b000: begin
            data = 8'hAF;
            next_state = enable ? 3'b001 : current_state;
        end
        3'b001: begin
            data = 8'hBC;
            next_state = enable ? 3'b010 : current_state;
        end
        3'b010: begin
            data = 8'hE2;
            next_state = enable ? 3'b011 : current_state;
        end
        3'b011: begin
            data = 8'h78;
            next_state = enable ? 3'b100 : current_state;
        end
        3'b100: begin
            data = 8'hFF;
            next_state = enable ? 3'b101 : current_state;
        end
        3'b101: begin
            data = 8'hE2;
            next_state = enable ? 3'b110 : current_state;
        end
        3'b110: begin
            data = 8'h0B;
            next_state = enable ? 3'b111 : current_state;
        end
        3'b111: begin
            data = 8'h8D;
            next_state = enable ? 3'b000 : current_state;
        end
        default: begin
            data = 8'h00;
            next_state = 3'b000;
        end
    endcase
end

endmodule

