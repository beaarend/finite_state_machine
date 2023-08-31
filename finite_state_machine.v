module finite_state_machine(
    // Constant pins:
    input HIGH,
    input LOW,

    // Control inputs:
    input clock,
    input reset,
    input up,

    // 7-segment outputs:
    output [6:0] seg
);

    // Wire declaration for the states
    wire [2:0] curr_state;
    wire [2:0] next_state;

    DFFRSE dff2(.q(curr_state[2]), .d(next_state[2]), .clk(clock), .reset(reset), .set(LOW), .enable(HIGH));
    DFFRSE dff1(.q(curr_state[1]), .d(next_state[1]), .clk(clock), .reset(reset), .set(LOW), .enable(HIGH));
    DFFRSE dff0(.q(curr_state[0]), .d(next_state[0]), .clk(clock), .reset(reset), .set(LOW), .enable(HIGH));

    //define_next_state next (.EA0(EA0), .EA1(EA1), .down(down), .PE0(PE0), .PE1(PE1));

    define_next_state next (.current(curr_state), .up(up), .next(next_state));

    define_output seven_segment (.current(curr_state), .HIGH(HIGH), .LOW(LOW), .segment(seg));

endmodule


