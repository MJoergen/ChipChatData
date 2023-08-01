module dice_roller (
    input wire clk,
    input wire reset_n,
    input wire [1:0] die_select,
    input wire roll,
    output reg [7:0] rolled_number
);

    // Define states for the state machine
    localparam IDLE = 2'd0, ROLLING = 2'd1;

    // Define the maximum number for each die
    localparam MAX_NUMBERS_4 = 4'd3;
    localparam MAX_NUMBERS_6 = 6'd5;
    localparam MAX_NUMBERS_8 = 8'd7;
    localparam MAX_NUMBERS_20 = 20'd19;

    // Define registers for the state machine
    reg [1:0] state_reg, state_next;
    reg [7:0] rolled_number_reg;

    // Define registers for the random number generator
    reg [3:0] rand_reg;
    reg [3:0] rand_next;

    // Initialize registers
    initial begin
        state_reg = IDLE;
        rolled_number_reg = 8'd0;
        rand_reg = 4'd0;
        rand_next = 4'd0;
    end

    // State machine logic
    always @ (posedge clk, negedge reset_n) begin
        if (~reset_n) begin
            state_reg <= IDLE;
            rolled_number_reg <= 8'd0;
            rand_reg <= 4'd0;
        end
        else begin
            state_reg <= state_next;
            rolled_number_reg <= rolled_number;
            rand_reg <= rand_next;
        end
    end

    // State transitions and output logic
    always @ (*) begin
        state_next = state_reg;
        rand_next = rand_reg;

        case (state_reg)
            IDLE:
                if (roll) begin
                    state_next = ROLLING;
                    rand_next = $random;
                end
            ROLLING:
                case (die_select)
                    2'b00:
                        if (rand_reg >= MAX_NUMBERS_4) begin
                            state_next = IDLE;
                            rolled_number = rand_reg % MAX_NUMBERS_4 + 1;
                        end
                    2'b01:
                        if (rand_reg >= MAX_NUMBERS_6) begin
                            state_next = IDLE;
                            rolled_number = rand_reg % MAX_NUMBERS_6 + 1;
                        end
                    2'b10:
                        if (rand_reg >= MAX_NUMBERS_8) begin
                            state_next = IDLE;
                            rolled_number = rand_reg % MAX_NUMBERS_8 + 1;
                        end
                    2'b11:
                        if (rand_reg >= MAX_NUMBERS_20) begin
                            state_next = IDLE;
                            rolled_number = rand_reg % MAX_NUMBERS_20 + 1;
                        end
                endcase
        endcase
    end

endmodule

