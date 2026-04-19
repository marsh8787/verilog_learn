module demux1to4(
    input  wire in,
    input  wire [1:0] sel,
    output wire y0,
    output wire y1,
    output wire y2,
    output wire y3
);
    assign y0 = in & (~sel[1]&~sel[0]);
    assign y1 = in & (sel[1]&~sel[0]);
    assign y2 = in & (sel[1]&sel[0]);
    assign y3 = in & (sel[1]&sel[0]);

endmodule