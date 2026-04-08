module alu_mux(
    input wire alu_src_sel,
    input wire [7:0] immediate,
    input wire [7:0] reg2_data,
    output wire [7:0] alu_in_2
);
    assign alu_in_2 = (alu_src_sel) ? immediate : reg2_data;
endmodule