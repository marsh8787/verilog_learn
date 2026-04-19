module cpu_fpga(
    input wire clk,
    input wire cpu_en_btn,
    input wire regssel_reset,
    input wire func_sel,
    output wire state_led,
    output wire [7:0] ins_led,
    output wire [7:0] seg0_fout,
    output wire [7:0] seg1_fout,
    output wire [7:0] seg2_fout,
    output wire [7:0] seg3_fout,    
    output wire [7:0] seg4_fout,
    output wire [7:0] seg5_fout        
);

    wire [8:0] bin0;
    wire [8:0] bin1;

    wire [7:0] reg0_data;
    wire [7:0] reg1_data;
    wire [7:0] reg2_data;
    wire [7:0] reg3_data;
    wire [7:0] reg4_data;
    wire [7:0] reg5_data;
    wire [7:0] reg6_data;
    wire [7:0] reg7_data;

    wire [7:0] count;

    wire reset;
    wire cpu_en_btn_p;
    wire regssel_reset_p;
    wire func_sel_s;

    cpu f_cpu(
        .clk(clk),
        .reset(reset),
        .cpu_en(cpu_en_btn_p),
        .count_out(count),
        .state_out(state_led),
        .instruction_out(ins_led),
        .reg0_out(reg0_data),
        .reg1_out(reg1_data),
        .reg2_out(reg2_data),
        .reg3_out(reg3_data),
        .reg4_out(reg4_data),
        .reg5_out(reg5_data),
        .reg6_out(reg6_data),
        .reg7_out(reg7_data)
    );

    control f_control(
        .clk(clk),
        .regs0_data_in(reg0_data),
        .regs1_data_in(reg1_data),
        .regs2_data_in(reg2_data),
        .regs3_data_in(reg3_data),
        .regs4_data_in(reg4_data),
        .regs5_data_in(reg5_data),
        .regs6_data_in(reg6_data),
        .regs7_data_in(reg7_data),
        .count_in(count),
        .regssel_reset(regssel_reset_p),
        .func_sel(func_sel_s),
        .bin0(bin0),
        .bin1(bin1),
        .reset_out(reset)
    );

    sevensegs f_sevensegs(
        .bin0(bin0),
        .bin1(bin1),
        .seg0_out(seg0_fout),
        .seg1_out(seg1_fout),
        .seg2_out(seg2_fout),
        .seg3_out(seg3_fout),
        .seg4_out(seg4_fout),
        .seg5_out(seg5_fout)
    );

    fpga_input f_input(
        .clk(clk),
        .cpu_en_btn(cpu_en_btn),
        .regssel_reset(regssel_reset),
        .func_sel(func_sel),
        .cpu_en_btn_p(cpu_en_btn_p),
        .regssel_reset_p(regssel_reset_p),
        .func_sel_s(func_sel_s)
    );

endmodule