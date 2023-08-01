module traffic_light (
    input wire clk,
    input wire reset_n,
    input wire enable,
    output reg red,
    output reg yellow,
    output reg green
);

    // Define states
    localparam IDLE = 2'b00;
    localparam RED_STATE = 2'b01;
    localparam GREEN_STATE = 2'b10;
    localparam YELLOW_STATE = 2'b11;

    // Define state register
    reg [1:0] state;

    // Define counter for state transitions
    reg [5:0] counter;

    // State transition logic
    always @(posedge clk or negedge reset_n)
    begin
        if (~reset_n)
        begin
            state <= IDLE;
            counter <= 0;
        end
        else if (enable)
        begin
            case (state)
                IDLE:
                    if (counter == 0)
                    begin
                        state <= RED_STATE;
                        counter <= 31;
                    end
                    else
                        counter <= counter - 1;
                RED_STATE:
                    if (counter == 0)
                    begin
                        state <= GREEN_STATE;
                        counter <= 19;
                    end
                    else
                        counter <= counter - 1;
                GREEN_STATE:
                    if (counter == 0)
                    begin
                        state <= YELLOW_STATE;
                        counter <= 6;
                    end
                    else
                        counter <= counter - 1;
                YELLOW_STATE:
                    if (counter == 0)
                    begin
                        state <= RED_STATE;
                        counter <= 31;
                    end
                    else
                        counter <= counter - 1;
            endcase
        end
        else
            counter <= 0;
    end

    // Output logic
    always @(state)
    begin
        red = (state == RED_STATE);
        yellow = (state == YELLOW_STATE);
        green = (state == GREEN_STATE);
    end

endmodule

