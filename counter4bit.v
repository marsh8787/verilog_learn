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