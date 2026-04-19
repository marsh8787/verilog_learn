module datamux(
    input wire [7:0] input1,
    input wire [7:0] input2,
    input wire sw,
    output wire [7:0] out
);
    assign out = (sw) ? input1 : input2;
endmodule