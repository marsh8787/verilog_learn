module threebytes_7segments(
    input [7:0] swin,
    input data_sel,
    input clk,
    input reset,
    output [7:0] seg1out,
    output [7:0] seg2out,
    output [7:0] seg3out
);
    wire [11:0] bcd;

    wire [3:0] segsig1;
    wire [3:0] segsig2;
    wire [3:0] segsig3;

    assign bcd[11:8] = segsig3;
    assign bcd[7:4] = segsig2;
    assign bcd[3:0] = segsig1;   

    wire [7:0] count;
    wire [7:0] bin;

    bin2bcd bi2bc(
        .bin(bin),
        .bcd(bcd)
    );

    sevenseg sevenseg1(
        .bcd(segsig1),
        .segout(seg1out)
    );

    sevenseg sevenseg2(
        .bcd(segsig2),
        .segout(seg2out)
    );

    sevenseg sevenseg3(
        .bcd(segsig3),
        .segout(seg3out)
    );

    program_counter pc(
        .clk(clk),
        .reset(reset),
        .count(count)
    );

    datamux dtmux(
        .input1(swin),
        .input2(count),
        .sw(data_sel),
        .out(bin)
    );

endmodule