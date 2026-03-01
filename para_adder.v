module para_adder #(
    parameter WIDTH = 2
) (
    input wire [WIDTH-1:0] A,
    input wire [WIDTH-1:0] B,
    output wire [WIDTH:0] SUM;\
);
    assign SUM = A + B;
endmodule
