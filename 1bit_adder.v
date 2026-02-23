module _1bit_adder (
    a,b,cin,s,cout
);

inout wire a,b,cin;
output wire s,cout;

assign {cout,s} = a + b + cin;

    
endmodule   