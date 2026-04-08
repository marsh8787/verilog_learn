module SR_Flip_Flop (
    input wire clk,
    input wire reset,
    input wire S,
    input wire R,
    output reg Q
);
    always @(posedge clk) begin
        if(reset)
            Q <= 0;
        else
            if(S && R)
                Q <= Q;
            else if(S)
                Q <= 1;
            else if(R)
                Q <= 0;        
    end
    
endmodule

module JK_Flip_Flop (
    input wire clk,
    input wire reset,
    input wire J,
    input wire K,
    output reg Q
);
    always @(posedge clk) begin
        if(reset)
            Q <= 0;
        else
            if(J && K)
                Q <= ~Q;
            else if(J)
                Q <= 1;
            else if(K)
                Q <= 0;
    end
    
endmodule