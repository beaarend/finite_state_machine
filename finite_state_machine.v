module finite_state_machine(
    // Constant pins
    input HIGH, input LOW,
    // Control input
    input clock, input reset,
    input down, input in,
    // Output
    output d_led,
    output f_led, //
    output [6:0] seg,
    output [2:0] led
);

    // Initial state
    wire nin;
    not(nin, in);

    // Frequency divider
    wire [1:0] freq_curr;
    wire [1:0] freq_next;
    wire divider;

    DFFRSE dff1(.q(freq_curr[1]), .d(freq_next[1]), .clk(clock), .reset(reset), .set(LOW), .enable(HIGH));
    DFFRSE dff0(.q(freq_curr[0]), .d(freq_next[0]), .clk(clock), .reset(reset), .set(LOW), .enable(HIGH));

    define_freq_next freq_next (.HIGH(HIGH), .LOW(LOW), .current(freq_curr), .next(freq_next));
    define_freq_output freq_out (.HIGH(HIGH), .LOW(LOW), .current(freq_curr), .led_output(divider));

    buf(f_led, divider);
    
    // Wire declaration
    wire [2:0] current;
    wire [2:0] next;

    DFFRSE ff2(.q(current[2]), .d(next[2]), .clk(clock), .reset(reset), .set(nin), .enable(divider));
    DFFRSE ff1(.q(current[1]), .d(next[1]), .clk(clock), .reset(nin), .set(LOW), .enable(divider));
    DFFRSE ff0(.q(current[0]), .d(next[0]), .clk(clock), .reset(nin), .set(LOW), .enable(divider)); 

    define_next_state next (.HIGH(HIGH), .LOW(LOW), .down(down), .current(current), .next(next));
    define_output out(.HIGH(HIGH), .LOW(LOW), .current(current), .led(led), .seg(seg));

    // Led used to indicate when the input down is pressed
    buf(d_led, down); 
    

endmodule