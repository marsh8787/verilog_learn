`timescale 1ns/1ps

module tb_andgate;

    reg a;
    reg b;
    wire c;

    andgate dut(
        .a(a),
        .b(b),
        .c(c)
    );

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_andgate);

        a = 0; b = 0;
        #5;
        a = 1; b = 0;
        #5;
        a = 0; b = 1;
        #5;
        a = 1; b = 1;
        #5;

        $finish;
    end


endmodule