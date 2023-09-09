module define_freq_next(
    // Constant pins
    input HIGH, input LOW,
    // Current states
    input [1:0] current,
    // Output
    output [1:0] next
);

    wire temp;
    
    //next[1] = B
    buf(next[1], current[0]);

    //next[0] = (!A*!B)
    nor(temp, current[1], current[0]);
    buf(next[0], temp);

endmodule