module fpga_input(
    input wire clk,

    input wire cpu_en_btn,
    input wire regssel_reset,
    input wire func_sel,

    output wire cpu_en_btn_p,
    output wire regssel_reset_p,
    output wire func_sel_s
);

    reg cpu_sync0,cpu_sync1;
    reg cpu_level0,cpu_level1;

    reg reset_sync0,reset_sync1;
    reg reset_level0,reset_level1;

    reg func_sync0,func_sync1;

    assign regssel_reset_p = reset_level0 & reset_level1;
    assign func_sel_s = func_sync1;

    assign cpu_en_btn_p = ~cpu_level0 & cpu_level1;
    always @(posedge clk) begin
        cpu_sync0 <= cpu_en_btn;
        cpu_sync1 <= cpu_sync0;

        cpu_level0 <= cpu_sync1;
        cpu_level1 <= cpu_level0;

        reset_sync0 <= regssel_reset;
        reset_sync1 <= reset_sync0;

        reset_level0 <= reset_sync1;
        reset_level1 <= reset_sync0;

        func_sync0 <= func_sel;
        func_sync1 <= func_sync0;
    end
endmodule