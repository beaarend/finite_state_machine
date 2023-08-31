module define_next_state(
    input [2:0] current,
    input up,
    output [2:0] next
);

    // Wire declaration 
    wire not_up;
    not(not_up, up);

    wire [2:0] not_current;
    not(not_current[2], current[2]);
    not(not_current[1], current[1]);
    not(not_current[0], current[0]);

    wire [4:0] temp_2;
    wire [1:0] temp_1;
    wire [2:0] temp_0;

    // Equations created using Karma
    // next[2] = (not_up*not_current[2]*not_current[0])+(up*not_current[2]*current[0])+(up*current[2]*not_current[0])+(not_up*current[2]*current[0])+(not_current[1])
    and(temp_2[0], not_up, not_current[2], not_current[0]);
    and(temp_2[1], up, not_current[2], current[0]);
    and(temp_2[2], up, current[2], not_current[0]);
    and(temp_2[3], not_up, current[2], current[0]);
    or(temp_2[4], temp_2[0], temp_2[1], temp_2[2], temp_2[3]);

    or(next[2], temp_2[4], not_current[1]);

    // next[1] = (up*current[0])+(not_current[2])+(not_up*not_current[0])
    and(temp_1[0], up, current[0]);
    and(temp_1[1], not_up, not_current[0]);

    or(next[1], temp_1[0], temp_1[1], not_current[2]);

    // next[0] = (up*not_current[1])+(not_up*current[2]*current[1])+(not_current[2]*not_current[0])
    and(temp_0[0], up, not_current[1]);
    and(temp_0[1], not_up, current[2], current[1]);
    and(temp_0[2], not_current[2], not_current[0]);

    or(next[0], temp_0[0], temp_0[1], temp_0[2]);

endmodule