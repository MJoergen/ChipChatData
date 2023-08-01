module traffic_light (
    input wire Clock,
    input wire Reset_n,
    input wire Enable,
    output reg Red,
    output reg Yellow,
    output reg Green
);

// Define state encoding
localparam RED = 2'b00, GREEN = 2'b01, YELLOW = 2'b10;

reg [1:0] state, next_state;
reg [5:0] counter;

// State transition
always @(posedge Clock or negedge Reset_n) begin
    if (~Reset_n) begin
        state <= RED;
        counter <= 6'd0;
    end else if (Enable) begin
        state <= next_state;
        case (state)
            RED:    counter <= (counter == 6'd31) ? 6'd0 : counter + 6'd1;
            GREEN:  counter <= (counter == 6'd19) ? 6'd0 : counter + 6'd1;
            YELLOW: counter <= (counter == 6'd6)  ? 6'd0 : counter + 6'd1;
            default: counter <= 6'd0;
        endcase
    end
end

// Next state logic
always @(*) begin
    next_state = state;
    case (state)
        RED:    if (counter == 6'd31) next_state = GREEN;
        GREEN:  if (counter == 6'd19) next_state = YELLOW;
        YELLOW: if (counter == 6'd6)  next_state = RED;
    endcase
end

// Output logic
always @(*) begin
    Red = (state == RED);
    Yellow = (state == YELLOW);
    Green = (state == GREEN);
end

endmodule

