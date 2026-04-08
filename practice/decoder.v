module decoder2to4(
    input  wire [1:0] sel,
    output wire y0,
    output wire y1,
    output wire y2,
    output wire y3
);

    assign y0 = ~sel[0]&~sel[1];
    assign y1 = sel[0]&~sel[1];
    assign y2 = ~sel[0]&sel[1];
    assign y3 = sel[0]&sel[1];

endmodule