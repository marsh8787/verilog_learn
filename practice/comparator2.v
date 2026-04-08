module comparator2 (
    input  wire [1:0] a,
    input  wire [1:0] b,
    output wire a_gt_b,
    output wire a_eq_b,
    output wire a_lt_b
);
    wire eq1,gt1,gt0,lt0,lt1,eq0;
    assign eq1 = ~(a[1] ^ b[1]);
    assign eq0 = ~(a[0] ^ b[0]);
    assign gt1 = a[1] & ~b[1];
    assign gt0 = a[0] & ~b[0];
    assign lt1 = ~a[1] & b[1];
    assign lt0 = ~a[0] & b[0];

    assign a_gt_b = gt1 | (eq1 & gt0);
    assign a_eq_b = eq1 & eq0;
    assign a_lt_b = lt1 | (eq1 & lt0);
endmodule