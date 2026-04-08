module writeback_mux(
    input wire [7:0] reg2_data,
    input wire [7:0] alu_result,
    input wire wb_data_sel,
    output wire [7:0] write_data
);
    assign write_data = (wb_data_sel) ? reg2_data : alu_result;
endmodule