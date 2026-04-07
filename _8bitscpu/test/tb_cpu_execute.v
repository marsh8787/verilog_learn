`timescale 1ps/1ps

module tb_cpu_execute;

    reg clk;
    reg reset;
    reg [10:0] instruction;

    wire [7:0] t_reg0;
    wire [7:0] t_reg1;
    wire [7:0] t_reg2;
    wire [7:0] t_reg3;
    wire [7:0] t_reg4;
    wire [7:0] t_reg5;
    wire [7:0] t_reg6;
    wire [7:0] t_reg7;

    cpu_execute uut (
        .clk(clk),
        .reset(reset),
        .instruction(instruction),
        .t_reg0(t_reg0),
        .t_reg1(t_reg1),
        .t_reg2(t_reg2),
        .t_reg3(t_reg3),
        .t_reg4(t_reg4),
        .t_reg5(t_reg5),
        .t_reg6(t_reg6),
        .t_reg7(t_reg7)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("tb_cpu_execute.vcd");
        $dumpvars(0,tb_cpu_execute);

        clk = 0;
        #10
        reset = 0;
        #10
        instruction = 11'b00001010100;
        #10
        instruction = 11'b01011010001;
        #10
        instruction = 11'b00111110000;
        #10

        $finish;

    end


endmodule 

