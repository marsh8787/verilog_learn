module counter4(
    input wire clk,
    input wire reset,
    output reg [3:0] Q
);
    always @(posedge clk)begin
        if(reset)
            Q <= 0;
        else
            Q <= Q + 1;
    end
endmodule

module counter10(
    input wire clk,
    input wire reset,
    output reg [3:0] Q
);
    always @(posedge clk)begin
        if(reset)
            Q <= 0;
        else if(Q == 4'b1001)
            Q <= 0;
        else
            Q <= Q + 1;
    end
endmodule