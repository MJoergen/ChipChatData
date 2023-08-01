module traffic_light_fsm (
    input wire clk,
    input wire reset_n,
    input wire enable,
    output reg red,
    output reg yellow,
    output reg green
);

// Define state encoding
localparam [1:0] RED = 2'b00;
localparam [1:0] GREEN = 2'b01;
localparam [1:0] YELLOW = 2'b10;

reg [1:0] current_state, next_state;

// Clock divider
reg [6:0] clk_divider;

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        clk_divider <= 7'd0;
        current_state <= RED;
    end else if (enable) begin
        // State transition on every 32, 20, or 7 clock cycles depending on the current state
        case (current_state)
            RED: begin
                if (clk_divider == 32 - 1) begin
                    clk_divider <= 7'd0;
                    current_state <= GREEN;
                end else begin
                    clk_divider <= clk_divider + 1;
                end
            end
            GREEN: begin
                if (clk_divider == 20 - 1) begin
                    clk_divider <= 7'd0;
                    current_state <= YELLOW;
                end else begin
                    clk_divider <= clk_divider + 1;
                end
            end
            YELLOW: begin
                if (clk_divider == 7 - 1) begin
                    clk_divider <= 7'd0;
                    current_state <= RED;
                end else begin
                    clk_divider <= clk_divider + 1;
                end
            end
            default: begin
                clk_divider <= 7'd0;
                current_state <= RED;
            end
        endcase
    end
end

// Next state logic
always @(*) begin
    case (current_state)
        RED: next_state = GREEN;
        GREEN: next_state = YELLOW;
        YELLOW: next_state = RED;
        default: next_state = RED;
    endcase
end

// Output logic
always @(*) begin
    red = (current_state == RED) ? 1'b1 : 1'b0;
    yellow = (current_state == YELLOW) ? 1'b1 : 1'b0;
    green = (current_state == GREEN) ? 1'b1 : 1'b0;
end

endmodule

