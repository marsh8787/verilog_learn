module encoder8to3_onehot (
    input wire [7:0] x,
    output wire [2:0] y
);

    assign y[0] = x[1] | x[3] | x[5] | x[7];
    assign y[1] = x[2] | x[3] | x[6] | x[7];
    assign y[2] = x[4] | x[5] | x[6] | x[7];

endmodule