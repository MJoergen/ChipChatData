module abro_state_machine (
    input clk,
    input rst_n,
    input A,
    input B,
    output O,
    output reg [3:0] State
);

    // State transitions
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            State <= 4'b0001;
        end else begin
            case (State)
                4'b0001: State <= (A && !B) ? 4'b0010 : State;
                4'b0010: State <= (!A && B) ? 4'b0001 : ((A && B) ? 4'b0100 : 4'b0010);
                4'b0100: State <= (!A && B) ? 4'b0001 : State;
                default: State <= 4'b0001;
            endcase
        end
    end

    // Output logic
    assign O = (State == 4'b0100) && A && B;

endmodule

