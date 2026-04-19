`timescale 1ps/1ps

module tb_bin2bcd;

    reg [7:0] t_bin;
    wire [11:0] t_bcd;

    bin2bcd uut(
        .bcd(t_bcd),
        .bin(t_bin)
    );

    initial begin
        $dumpfile("tb_bin2bcd.vcd");
        $dumpvars(0,tb_bin2bcd);

        t_bin = 8'b00001000;
        #10;
        t_bin = 8'b00001110;
        #10;
        t_bin = 8'b11010101;

        $finish;
    end

endmodule