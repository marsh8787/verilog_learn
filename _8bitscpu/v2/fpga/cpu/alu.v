module alu(
    input wire [7:0] input1,
    input wire [7:0] input2,
    output wire [7:0] alu_result
);
    assign alu_result = input1 + input2;      
endmodule