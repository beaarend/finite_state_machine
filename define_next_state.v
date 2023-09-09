module next_state(
    // Constant pins
    input HIGH, input LOW,
    // Control input
    input down, input [2:0] current,
    // Output
    output [2:0] next
);

    // Wire declaration
    wire [10:0] temp;

    wire [2:0] not_current;
    not(not_current[2], current[2]);
    not(not_current[1], current[1]);
    not(not_current[0], current[0]);

    wire not_down;
    not(not_down, down);

    /* 
    Equations created using Karma, A = down, B = current[2], C = current[1], D = current[0]
                                  !A = not_down, !B = not_current[2], !C = not_current[1], !D = not_current[0]
    */

    // next[2] = (A*!B*D)+(A*B*!D)+(!C)+(!A*B*D)+(!A*!B*!D)
    and(temp[0], down, not_current[2], current[0]);
    and(temp[1], down, current[2], not_current[0]);
    and(temp[2], not_down, current[2], current[0]);
    and(temp[3], not_down, not_current[2], not_current[0]);
    or(temp[4], temp[0], temp[1], temp[2], temp[3]);
    or(next[2], temp[4], not_current[1]);

    // next[1] = (!A*B*!D)+(A*B*D)+(!B*C)
    and(temp[5], not_down, current[2], not_current[0]);
    and(temp[6], down, current[2], current[0]);
    and(temp[7], not_current[2], current[1]);
    or (next[1], temp[5], temp[6], temp[7]);

    // next[0] = (A*!C)+(!A*B*C)+(!B*C*!D)
    and(temp[8], down, not_current[1]);
    and(temp[9], not_down, current[2], current[1]);
    and(temp[10], not_current[2], not_current[0], current[1]);
    or (next[0], temp[8], temp[9], temp[10]);

endmodule