module define_next_state(
    input [2:0] current,
    input HIGH, 
    input LOW,
    output [6:0] segment
);

    // Wire declaration 
    wire [2:0] not_current;
    not(not_current[2], current[2]);
    not(not_current[1], current[1]);
    not(not_current[0], current[0]);

    wire [1:0] temp_5;
    wire [1:0] temp_3;

    // Equations created using Karma
    //segment[6] = HIGH
    buf(segment[6], HIGH);

    //segment[5] = (current[2]*current[1])+(not_current[1]*current[0])
    and(temp_5[0], current[2], current[1]);
    and(temp_5[1], not_current[1], current[0]);
    or(segment[5], temp_5[0], temp_5[1]);

    //segment[4] = LOW
    buf(segment[4], LOW);

    //segment[3] = (not_current[1]*not_current[0])+(current[1]*current[0])+(not_current[2])
    and(temp_3[0], not_current[1], not_current[0]);
    and(temp_3[1], not_current[1], not_current[0]);
    or(segment[3], temp_3[0], temp_3[1], not_current[2]);

    //segment[2] = HIGH
    buf(segment[2], HIGH);

    //segment[1] = (not_current[1])+(not_current[0])+(not_current[2])
    nand(segment[1], current[2], current[1], current[0]);

    //segment[0] = segment[3]
    buf(segment[0], segment[3]);
    
endmodule