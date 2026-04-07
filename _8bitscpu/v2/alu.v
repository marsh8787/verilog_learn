module alu(
    input wire [7:0] input1,
    input wire [7:0] input2,
    input wire [1:0]opcode,
    output reg [7:0] alu_result
);
    always @(*) begin
        case(opcode)
            2'b00 : 
                alu_result <= input1 + input2;
            2'b01 : 
                alu_result <= input1 + input2;
            default : 
                alu_result <= 0;
        endcase
    end      
endmodule