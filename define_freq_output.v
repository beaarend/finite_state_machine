module define_freq_output(
    // Constant pins
    input HIGH, input LOW,
    // Current states
    input [1:0] current,
    // Output
    output led_output //
);

   buf(led_output, current[1]);
    
endmodule