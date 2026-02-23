module comparator4(
    input  wire [3:0] a,
    input  wire [3:0] b,
    output wire a_gt_b,
    output wire a_eq_b,
    output wire a_lt_b
);
    wire eq3,eq2,eq1,eq0;
    wire gt3,gt2,gt1,gt0;
    wire lt3,lt2,lt1,lt0;

    assign eq3 = ~(a[3] ^ b[3]);
    assign eq2 = ~(a[2] ^ b[2]);
    assign eq1 = ~(a[1] ^ b[1]);
    assign eq0 = ~(a[0] ^ b[0]);
    

    assign gt3 = a[3] & ~b[3];
    assign gt2 = a[2] & ~b[2];
    assign gt1 = a[1] & ~b[1];
    assign gt0 = a[0] & ~b[0];

    assign lt3 = ~a[3] & b[3];
    assign lt2 = ~a[2] & b[2];
    assign lt1 = ~a[1] & b[1];
    assign lt0 = ~a[0] & b[0];

    assign a_eq_b = eq3 & eq2 & eq1 & eq0;
    assign a_gt_b = (gt3) | (eq3 & gt2) | (eq3 & eq2 & gt1) | (eq3 & eq2 & eq1 & gt0);
    assign a_lt_b = (lt3) | (eq3 & lt2) | (eq3 & eq2 & lt1) | (eq3 & eq2 & eq1 & lt0);



endmodule
