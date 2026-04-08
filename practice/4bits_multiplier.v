module _4bit_multiplier (
    a,b,out
);
    input wire signed [3:0] a,b;
    output wire [7:0] out;

    assign out = a*b;
endmodule