module ABRO_StateMachine (
  input wire clk,
  input wire reset_n,
  input wire A,
  input wire B,
  output wire O,
  output wire [3:0] State
);
  // State register
  reg [3:0] state_reg;
  // Next state logic
  always @(posedge clk or negedge reset_n) begin
    if (~reset_n) begin
      state_reg <= 4'b0001; // Initialize to state A
    end else begin
      case (state_reg)
        // State A
        4'b0001: begin
          if (A) begin
            state_reg <= 4'b0010; // Transition to state B
          end
        end
        // State B
        4'b0010: begin
          if (B) begin
            state_reg <= 4'b0100; // Transition to state R
          end
        end
        // State R
        4'b0100: begin
          if (~B) begin
            state_reg <= 4'b1000; // Transition to state O
          end
        end
        // State O
        4'b1000: begin
          if (A) begin
            state_reg <= 4'b0001; // Transition back to state A
          end
        end
        default: state_reg <= 4'b0001; // Default to state A if undefined state
      endcase
    end
  end

  // Output assignment
  assign O = (state_reg == 4'b1000) ? 1'b1 : 1'b0;
  assign State = state_reg;

endmodule

