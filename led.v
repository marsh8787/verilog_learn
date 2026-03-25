module led(
    input wire btn,
    output wire led
);
    assign led = btn;
endmodule

module ledflash(
    input wire clk,
    input wire reset,
    output reg led
);
    reg [25:0] cnt;

    always @(posedge clk)begin
        if(!reset)begin
            led <= 0;
            cnt <= 0;
        end
        else if(cnt == 26'd49_999_999)begin
            cnt <= 0;
            led <= ~led;
        end
        else
            cnt <= cnt + 26'd1;
    end
endmodule

module ledflow(
    input wire clk,
    input wire reset,
    output reg [9:0] LED
);

    initial begin
        LED = 10'b000_000_000_1;
    end
    reg [25:0] cnt;

    always @(posedge clk)begin
        if(!reset)begin
            cnt <= 0;
            LED <= 10'b000_000_000_1;
        end
        else if(cnt == 26'd49_999_999)begin
            cnt <= 0;
            LED <= {LED[8:0],LED[9]};
        end
        else begin
            cnt <= cnt+1;
        end
    end
endmodule

