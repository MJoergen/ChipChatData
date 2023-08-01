module sequence_detector(
    input wire clk,
    input wire reset_n, // Active-low reset
    input wire [2:0] data,
    output reg sequence_found
);

// Define the states of the FSM
parameter S_IDLE = 4'b0000;
parameter S1 = 4'b0001;
parameter S2 = 4'b0010;
parameter S3 = 4'b0011;
parameter S4 = 4'b0100;
parameter S5 = 4'b0101;
parameter S6 = 4'b0110;
parameter S7 = 4'b0111;

reg [3:0] current_state, next_state;

// FSM state transition logic
always @(*) begin
    next_state = current_state;
    case (current_state)
        S_IDLE: next_state = (data == 3'b001) ? S1 : S_IDLE;
        S1: next_state = (data == 3'b101) ? S2 : S_IDLE;
        S2: next_state = (data == 3'b110) ? S3 : S_IDLE;
        S3: next_state = (data == 3'b000) ? S4 : S_IDLE;
        S4: next_state = (data == 3'b110) ? S5 : S_IDLE;
        S5: next_state = (data == 3'b110) ? S6 : S_IDLE;
        S6: next_state = (data == 3'b011) ? S7 : S_IDLE;
        S7: next_state = (data == 3'b101) ? S_IDLE : S_IDLE;
    endcase
end

// FSM output logic and state register
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        current_state <= S_IDLE;
        sequence_found <= 1'b0;
    end else begin
        current_state <= next_state;
        sequence_found <= (next_state == S7) ? 1'b1 : 1'b0;
    end
end

endmodule

