module ABRO_StateMachine (
  input wire clock,
  input wire reset,
  input wire A,
  input wire B,
  output reg O,
  output reg [3:0] State
);
  reg [3:0] next_State;

  always @(posedge clock) begin
    if (reset) begin
      next_State <= 4'b0001;
      O <= 0;
    end
    else begin
      case (State)
        4'b0001:
          if (A) next_State <= 4'b0010;
        4'b0010:
          if (!A) next_State <= 4'b0100;
        4'b0100:
          if (B) next_State <= 4'b1000;
        4'b1000:
          if (!B) next_State <= 4'b0001;
      endcase
    end
  end

  always @(posedge clock) begin
    State <= next_State;
    O <= (State == 4'b0010 || State == 4'b1000);
  end
endmodule

