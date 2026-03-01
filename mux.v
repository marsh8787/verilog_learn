module mux2 (
    input wire a,
    input wire b,
    input wire sel,
    output wire out
);

    assign out = (a&~sel) | (b&sel);

endmodule

module mux4 (
    input  wire d0,
    input  wire d1,
    input  wire d2,
    input  wire d3,
    input  wire [1:0] sel,
    output wire out
);

    wire w0,w1;

    mux2 mu2_1(
        .a(d0),
        .b(d1),
        .sel(sel[0]),
        .out(w0)
    );

    mux2 mu2_2(
        .a(d2),
        .b(d3),
        .sel(sel[0]),
        .out(w1)
    );

    mux2 mu2_3(
        .a(w0),
        .b(w1),
        .sel(sel[1]),
        .out(out)
    );
    
    
endmodule

module mux(
    input wire a,
    input wire b,
    input wire c,
    input wire d,
    input wire [1:0] sel,
    output reg out
);
    always @(*) begin
        case(sel)
            2'b00: out = a;
            2'b01: out = b;
            2'b10: out = c;
            2'b11: out = d;
            default: out = a; 
        endcase
    end
endmodule

module para_mux #(
    parameter WIDTH = 8
)(
    input wire [WIDTH-1:0] A,
    input wire [WIDTH-1:0] B,
    input wire sel,
    output wire [WIDTH-1:0] Y
);
    assign Y = sel ? B:A;
    
endmodule