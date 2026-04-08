module instruction_decoder(
    input wire [7:0] instruction,
    output wire [1:0] opcode,
    output wire [2:0] reg1_addr,
    output wire [2:0] reg2_addr
);
    assign opcode = instruction[7:6];
    assign reg1_addr = instruction[5:3];
    assign reg2_addr = instruction[2:0];
endmodule