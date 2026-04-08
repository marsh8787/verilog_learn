`timescale 1ps/1ps

module tb_cpu;

    reg clk;
    reg reset;

    wire [7:0] t_count;
    wire [7:0] t_instruction;
    wire [7:0] t_reg0;
    wire [7:0] t_reg1;
    wire [7:0] t_reg2;
    wire [7:0] t_reg3;
    wire [7:0] t_reg4;
    wire [7:0] t_reg5;
    wire [7:0] t_reg6;
    wire [7:0] t_reg7;

    cpu uut(
        .clk(clk),
        .reset(reset),
        .t_count(t_count),
        .t_instruction(t_instruction),
        .t_reg0(t_reg0),
        .t_reg1(t_reg1),
        .t_reg2(t_reg2),
        .t_reg3(t_reg3),
        .t_reg4(t_reg4),
        .t_reg5(t_reg5),
        .t_reg6(t_reg6),
        .t_reg7(t_reg7),
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("tb_cou.vcd");
        $dumpfile(0,tb_cpu);

        clk = 0;
        #10
        reset = 1;
        #10000

        $finish;
    end

endmodule