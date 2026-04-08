module branch_control(
    input wire branch_en,
    input wire [7:0] reg1_data,
    output wire branch_taken 
);
    assign branch_taken = (branch_en & !(|reg1_data));
endmodule