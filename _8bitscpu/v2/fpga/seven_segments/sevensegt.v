module sevenseg(
    input wire [3:0] bcd,
    output reg [7:0] segout
);
    always @(*)begin
        case(bcd)
            4'b0000: segout = ~(8'b001_111_11);
            4'b0001: segout = ~(8'b000_001_10);
            4'b0010: segout = ~(8'b010_110_11);
            4'b0011: segout = ~(8'b010_011_11);
            4'b0100: segout = ~(8'b011_001_10);
            4'b0101: segout = ~(8'b011_011_01);
            4'b0110: segout = ~(8'b011_111_01);
            4'b0111: segout = ~(8'b001_001_11);
            4'b1000: segout = ~(8'b011_111_11);
            4'b1001: segout = ~(8'b011_001_11);
            default: segout = ~(8'b110_000_00);
        endcase
    end
endmodule