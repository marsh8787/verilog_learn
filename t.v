  module and_gate (
    input a,
    input b,
    output c
    );

  assign c = b & a;
    
  endmodule

module not_gate (a,b,c);
input a;
input b;
output c;

assign c = a & b;

endmodule

module or_gate (
  input wire a,
  input wire b,
  output reg c
  );

always @(*) begin
  c = a | b;
end
    
endmodule