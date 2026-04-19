module control(
    input wire clk,

    input wire [7:0] regs0_data_in,
    input wire [7:0] regs1_data_in,
    input wire [7:0] regs2_data_in,
    input wire [7:0] regs3_data_in,
    input wire [7:0] regs4_data_in,
    input wire [7:0] regs5_data_in,
    input wire [7:0] regs6_data_in,
    input wire [7:0] regs7_data_in,
    input wire [7:0] count_in,

    input wire regssel_reset,
    input wire func_sel,

    output reg [8:0] bin0,
    output reg [8:0] bin1,
    output wire reset_out
);

    localparam 
        PRE_P_REG01 = 4'b0000, 
        P_REG01 = 4'b0001,
        PRE_P_REG23 = 4'b0010,
        P_REG23 = 4'b0011,
        PRE_P_REG45 = 4'b0100,
        P_REG45 = 4'b0101,
        PRE_P_REG67 = 4'b0110,
        P_REG67 = 4'b0111,
        PRE_P_COUNT = 4'b1000,
        P_COUNT = 4'b1001;

    localparam
        REG = 9'b100_000_000,
        ZERO_ONE = 9'b100_000_001,
        TWO_THREE = 9'b100_000_010,
        FOUR_FIVE = 9'b100_000_011,
        SIX_SEVEN = 9'b100_000_100,
        COU = 9'b100_000_101,
        NT = 9'b100_000_110;


    reg [3:0] state;
    reg [3:0] next_state;

    reg [26:0] time_cnt;

    assign reset_out = (!regssel_reset & !func_sel);

    always @(posedge clk) begin
        if(!regssel_reset & !func_sel) begin
            state <= PRE_P_REG01;
        end
        else begin
            state <= next_state;
        end
    end

    always @(posedge clk) begin
        if(!regssel_reset & !func_sel)begin
            time_cnt <= 0;
				next_state <= PRE_P_REG01;
        end
        else if(time_cnt == 100000001) begin
            time_cnt <= 0;
        end
        else begin
            time_cnt <= time_cnt + 1;
        end
        if(state == PRE_P_REG01 || state == PRE_P_REG23 || state == PRE_P_REG45 || state == PRE_P_REG67 || state == PRE_P_COUNT) begin
            if(time_cnt > 99999999) begin
                case(state)
                    PRE_P_REG01:
                        next_state <= P_REG01;
                    PRE_P_REG23:
                        next_state <= P_REG23;
                    PRE_P_REG45:
                        next_state <= P_REG45;
                    PRE_P_REG67:
                        next_state <= P_REG67;
                    PRE_P_COUNT:
                        next_state <= P_COUNT;
                    default:
                        next_state <= PRE_P_REG01;
                endcase
            end
        end
        else begin
            if(!regssel_reset & func_sel) begin
                case(state)
                    P_REG01:
                        next_state <= PRE_P_REG23;
                    P_REG23:
                        next_state <= PRE_P_REG45;
                    P_REG45:
                        next_state <= PRE_P_REG67;
                    P_REG67:
                        next_state <= PRE_P_COUNT;
                    P_COUNT:
                        next_state <= PRE_P_REG01;
                    default:
                        next_state <= PRE_P_REG01;
                endcase
                time_cnt <= 0;
            end
        end

    end

    always @(*) begin
        case(state)
            PRE_P_REG01:
                begin
                    bin0 = REG;
                    bin1 = ZERO_ONE;
                end
            P_REG01:
                begin
                    bin0 = {1'b0,regs0_data_in};
                    bin1 = {1'b0,regs1_data_in};
                end
            PRE_P_REG23:
                begin
                    bin0 = REG;
                    bin1 = TWO_THREE;
                end
            P_REG23:
                begin
                    bin0 = {1'b0,regs2_data_in};
                    bin1 = {1'b0,regs3_data_in};
                end
            PRE_P_REG45:
                begin
                    bin0 = REG;
                    bin1 = FOUR_FIVE;
                end
            P_REG45:
                begin
                    bin0 = {1'b0,regs4_data_in};
                    bin1 = {1'b0,regs5_data_in};
                end
            PRE_P_REG67:
                begin
                    bin0 = REG;
                    bin1 = SIX_SEVEN;
                end
            P_REG67:
                begin
                    bin0 = {1'b0,regs6_data_in};
                    bin1 = {1'b0,regs7_data_in};
                end
            PRE_P_COUNT:
                begin
                    bin0 = COU;
                    bin1 = NT;
                end
            P_COUNT:
                begin
                    bin0 = 9'b000_000_000;
                    bin1 = {1'b0,count_in};
                end
            default:
                begin
                    bin0 = 9'b000_000_000;
                    bin1 = 9'b000_000_000;
                end
        endcase
    end
        
    
        


endmodule