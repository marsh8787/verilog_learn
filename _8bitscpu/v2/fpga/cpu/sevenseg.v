
module sevensegs(
    input wire [8:0] bin0,
    input wire [8:0] bin1,
    output reg [7:0] seg0_out,
    output reg [7:0] seg1_out,
    output reg [7:0] seg2_out,
    output reg [7:0] seg3_out,
    output reg [7:0] seg4_out,
    output reg [7:0] seg5_out
);

    integer i;
    integer k;

    reg [19:0] temp0;
    reg [19:0] temp1;

    reg [4:0] seg0;
    reg [4:0] seg1;
    reg [4:0] seg2;
    reg [4:0] seg3;
    reg [4:0] seg4;
    reg [4:0] seg5;

    localparam
        REG = 9'b100_000_000,
        ZERO_ONE = 9'b100_000_001,
        TWO_THREE = 9'b100_000_010,
        FOUR_FIVE = 9'b100_000_011,
        SIX_SEVEN = 9'b100_000_100,
        COU = 9'b100_000_101,
        NT = 9'b100_000_110;

    localparam
        ZERO = 5'b000_00,
        ONE = 5'b000_01,
        TWO = 5'b000_10,
        THREE = 5'b000_11,
        FOUR = 5'b001_00,
        FIVE = 5'b001_01,
        SIX = 5'b001_10,
        SEVEN = 5'b001_11,
        EIGHT = 5'b010_00,
        NINE = 5'b010_01,
        R = 5'b010_10,
        E = 5'b010_11,
        G = 5'b011_00,
        C = 5'b011_01,
        O = 5'b011_10,
        U = 5'b011_11,
        N = 5'b100_00,
        T = 5'b100_01,
        U_LINE = 5'b100_10,
        NONE = 5'b100_11;

    always @(bin0) begin
        for(i = 0;i < 20;i = i + 1) temp0[i] = 0;
        temp0[7:0] = bin0[7:0];
        for(i = 0; i < 8;i = i + 1) begin
            if(temp0[19:16] > 4) temp0[19:16] = temp0[19:16] + 3'b011;
            if(temp0[15:12] > 4) temp0[15:12] = temp0[15:12] + 3'b011;
            if(temp0[11:8] > 4) temp0[11:8] = temp0[11:8] + 3'b011;
            temp0 = temp0 << 1;
        end
    end

    always @(*) begin
        if(bin0[8]) begin
            case(bin0)
                REG:
                    begin
                        seg5 = R;
                        seg4 = E;
                        seg3 = G;
                    end
                COU:
                    begin
                        seg5 = C;
                        seg4 = O;
                        seg3 = U;
                    end
                default:
                    begin
                        seg5 = NONE;
                        seg4 = NONE;
                        seg3 = NONE;
                    end
            endcase
        end
        else begin
            seg5 = {1'b0,temp0[19:16]};
            seg4 = {1'b0,temp0[15:12]};
            seg3 = {1'b0,temp0[11:8]};
        end
    end

    always @(bin1) begin
        for(k = 0;k < 20;k = k + 1) temp1[k] = 0;
        temp1[7:0] = bin1[7:0];
        for(k = 0; k < 8;k = k + 1) begin
            if(temp1[19:16] > 4) temp1[19:16] = temp1[19:16] + 3'b011;
            if(temp1[15:12] > 4) temp1[15:12] = temp1[15:12] + 3'b011;
            if(temp1[11:8] > 4) temp1[11:8] = temp1[11:8] + 3'b011;
            temp1 = temp1 << 1;
        end
    end

    always @(*) begin
        if(bin1[8]) begin
            case(bin1)
                ZERO_ONE:
                    begin
                        seg2 = ZERO;
                        seg1 = U_LINE;
                        seg0 = ONE;
                    end
                TWO_THREE:
                    begin
                        seg2 = TWO;
                        seg1 = U_LINE;
                        seg0 = THREE;
                    end
                FOUR_FIVE:
                    begin
                        seg2 = FOUR;
                        seg1 = U_LINE;
                        seg0 = FIVE;
                    end
                SIX_SEVEN:
                    begin
                        seg2 = SIX;
                        seg1 = U_LINE;
                        seg0 = SEVEN;
                    end
                NT:
                    begin
                        seg2 = N;
                        seg1 = T;
                        seg0 = NONE;
                    end
                default:
                    begin
                        seg2 = NONE;
                        seg1 = NONE;
                        seg0 = NONE;
                    end
            endcase
        end
        else begin
            seg2 = {1'b0,temp1[19:16]};
            seg1 = {1'b0,temp1[15:12]};
            seg0 = {1'b0,temp1[11:8]};
        end
    end

    function [7:0] seg_encode;
        input [4:0] value;
        begin
            case(value)
                5'b000_00: seg_encode = ~(8'b001_111_11);
                5'b000_01: seg_encode = ~(8'b000_001_10);
                5'b000_10: seg_encode = ~(8'b010_110_11);
                5'b000_11: seg_encode = ~(8'b010_011_11);
                5'b001_00: seg_encode = ~(8'b011_001_10);
                5'b001_01: seg_encode = ~(8'b011_011_01);
                5'b001_10: seg_encode = ~(8'b011_111_01);
                5'b001_11: seg_encode = ~(8'b001_001_11);
                5'b010_00: seg_encode = ~(8'b011_111_11);
                5'b010_01: seg_encode = ~(8'b011_001_11);
                5'b010_10: seg_encode = ~(8'b011_100_00); //R
                5'b010_11: seg_encode = ~(8'b011_110_01); //E
                5'b011_00: seg_encode = ~(8'b011_011_11); //G
                5'b011_01: seg_encode = ~(8'b001_110_01); //C
                5'b011_10: seg_encode = ~(8'b001_111_11); //O
                5'b011_11: seg_encode = ~(8'b001_111_10); //U
                5'b100_00: seg_encode = ~(8'b010_101_00); //N
                5'b100_01: seg_encode = ~(8'b011_110_00); //T
                5'b100_10: seg_encode = ~(8'b000_010_00); //U_LINE
                5'b100_11: seg_encode = ~(8'b000_000_00); //NONE
                default: seg_encode = ~(8'b110_000_00);
            endcase
        end
    endfunction

    always @(*) begin
        seg0_out = seg_encode(seg0);
        seg1_out = seg_encode(seg1);
        seg2_out = seg_encode(seg2);
        seg3_out = seg_encode(seg3);
        seg4_out = seg_encode(seg4);
        seg5_out = seg_encode(seg5);
    end
endmodule