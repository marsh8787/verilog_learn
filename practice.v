module half_adder (
    a,b,sum,cout
);
    input wire a,b;
    output wire sum,cout;

    assign sum = a^b;
    assign cout = a&b;
endmodule

module full_adder (
    a,b,cin,sum,cout
);
    input wire a,b,cin;
    output wire sum,cout;

    wire s1,c1,c2;

    half_adder ha1(
        .a(a),
        .b(b),
        .sum(s1),
        .cout(c1)
    );
    half_adder ha2(
        .a(cin),
        .b(s1),
        .sum(sum),
        .cout(c2)
    );

    assign cout = c1 | c2;
    
endmodule

module ripple_carry_adder_4bit(
    a,b,cin,sum,cout
);
    input wire [3:0] a,b;
    input wire cin;
    output wire [3:0] sum;
    output wire cout;

    wire c1,c2,c3;

    full_adder fa1(
        .a(a[0]),
        .b(b[0]),
        .cin(cin),
        .sum(sum[0]),
        .cout(c1)
    );

    full_adder fa2(
        .a(a[1]),
        .b(b[1]),
        .cin(c1),
        .sum(sum[1]),
        .cout(c2)
    );

    full_adder fa3(
        .a(a[2]),
        .b(b[2]),
        .cin(c2),
        .sum(sum[2]),
        .cout(c3)
    );

    full_adder fa4(
        .a(a[3]),
        .b(b[3]),
        .cin(c3),
        .sum(sum[3]),
        .cout(cout)
    );


endmodule