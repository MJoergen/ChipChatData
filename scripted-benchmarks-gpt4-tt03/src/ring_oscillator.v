module enabled_ring_oscillator(
    input wire enable,
    output wire oscillate
);

    // Internal signals
    wire inv1_out, inv2_out, inv3_out;

    // NOT gate (inverter) instances
    not inv1 (inv1_out, enable & inv3_out);
    not inv2 (inv2_out, inv1_out);
    not inv3 (inv3_out, inv2_out);

    // Output signal
    assign oscillate = inv3_out;

endmodule

