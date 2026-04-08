module decoder3to8(
    input  wire [2:0] sel,
    output wire y0,
    output wire y1,
    output wire y2,
    output wire y3,
    output wire y4,
    output wire y5,
    output wire y6,
    output wire y7
);

    assign y0 = ~sel[2] & ~sel[1] & ~sel[0];//000
    assign y1 = ~sel[2] & ~sel[1] & sel[0];//001
    assign y2 = ~sel[2] & sel[1] & ~sel[0];//010
    assign y3 = ~sel[2] & sel[1] & sel[0];//011
    assign y4 = sel[2] & ~sel[1] & ~sel[0];//100
    assign y5 = sel[2] & ~sel[1] & sel[0];//101
    assign y6 = sel[2] & sel[1] & ~sel[0];//110
    assign y7 = sel[2] & sel[1] & sel[0];//111

endmodule