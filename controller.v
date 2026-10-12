// =============================================================================
// Course: VLSI Testing & DFT Practice (EC5034)
// Lab 1: Sequential Multiplier - Controller FSM
// Starter Template: Students must implement the FSM logic below.
// =============================================================================

module controller (
    input clk,
    input reset,
    
    // Inputs from Datapath & Testbench
    input start,
    input loops_zero_flag,
    
    // Control Outputs to Datapath
    output reg load_inputs,
    output reg clear_prod,
    output reg enable_prod,
    output reg enable_cnt_dec,
    
    // Status Output
    output reg mult_complete
);

    // TODO: Define your state encodings (IDLE, LOAD, PROG, DONE)
    // parameter IDLE = ...;

    // TODO: Implement the sequential state memory register

    // TODO: Implement next state and control output combinational logic

endmodule
