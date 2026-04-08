module adder (
    a,b,cin,s,cout
);

inout wire a,b,cin;
output wire s,cout;

assign {cout,s} = a + b + cin;

    
endmodule 

module adder4 (
    input [3:0] A,
    input [3:0] B,
    output wire [4:0] OUT
);
    module adder(
        .
    )