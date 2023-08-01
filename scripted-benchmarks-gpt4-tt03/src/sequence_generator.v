module sequence_generator (
    input wire clock,
    input wire reset_n, // active-low reset
    input wire enable,
    output reg [7:0] data // 8-bit output
);

// Define states as parameters
parameter S_AF = 3'b000,
          S_BC = 3'b001,
          S_E2 = 3'b010,
          S_78 = 3'b011,
          S_FF = 3'b100,
          S_E2_REPEAT = 3'b101,
          S_0B = 3'b110,
          S_8D = 3'b111;

// Declare FSM state registers
reg [2:0] state, next_state;

// Combinational logic for next state and output
always @(*) begin
    case (state)
        S_AF: begin
            data = 8'hAF;
            next_state = enable ? S_BC : state;
        end
        S_BC: begin
            data = 8'hBC;
            next_state = enable ? S_E2 : state;
        end
        S_E2: begin
            data = 8'hE2;
            next_state = enable ? S_78 : state;
        end
        S_78: begin
            data = 8'h78;
            next_state = enable ? S_FF : state;
        end
        S_FF: begin
            data = 8'hFF;
            next_state = enable ? S_E2_REPEAT : state;
        end
        S_E2_REPEAT: begin
            data = 8'hE2;
            next_state = enable ? S_0B : state;
        end
        S_0B: begin
            data = 8'h0B;
            next_state = enable ? S_8D : state;
        end
        S_8D: begin
            data = 8'h8D;
            next_state = enable ? S_AF : state;
        end
        default: begin
            data = 8'hAF;
            next_state = S_AF;
        end
    endcase
end

// Sequential logic for FSM state updates
always @(posedge clock or negedge reset_n) begin
    if (!reset_n) begin
        state <= S_AF; // Reset to the initial state
    end else begin
        state <= next_state; // Update state on the rising edge of the clock
    end
end

endmodule
