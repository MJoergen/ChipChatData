module sequence_generator (
    input wire clk,
    input wire reset_n, // active-low reset
    input wire enable,
    output reg [7:0] data
);

// State encoding
localparam [2:0] S_AF = 3'b000,
                 S_BC = 3'b001,
                 S_E2_1 = 3'b010,
                 S_78 = 3'b011,
                 S_FF = 3'b100,
                 S_E2_2 = 3'b101,
                 S_0B = 3'b110,
                 S_8D = 3'b111;

// Internal FSM state
reg [2:0] state, next_state;

// Next state logic
always @(*) begin
    next_state = state;
    if (enable) begin
        case (state)
            S_AF: next_state = S_BC;
            S_BC: next_state = S_E2_1;
            S_E2_1: next_state = S_78;
            S_78: next_state = S_FF;
            S_FF: next_state = S_E2_2;
            S_E2_2: next_state = S_0B;
            S_0B: next_state = S_8D;
            S_8D: next_state = S_AF;
        endcase
    end
end

// Output logic
always @(*) begin
    if (enable) begin
        case (state)
            S_AF: data = 8'hAF;
            S_BC: data = 8'hBC;
            S_E2_1: data = 8'hE2;
            S_78: data = 8'h78;
            S_FF: data = 8'hFF;
            S_E2_2: data = 8'hE2;
            S_0B: data = 8'h0B;
            S_8D: data = 8'h8D;
            default: data = 8'h00;
        endcase
    end
    // When enable is de-asserted, data retains its last value
end

// State register
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        state <= S_AF;
    end else begin
        state <= next_state;
    end
end

endmodule

