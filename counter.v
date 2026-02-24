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
        else if(Q >= 4'b1001)
            Q <= 0;
        else
            Q <= Q + 1;
    end
endmodule

module _4bits_updown_en_counter(
    input wire clk,
    input wire en,
    input wire reset,
    input wire dir,
    output reg [3:0] Q
);

    always @(posedge clk) begin
        if(reset)
            Q <= 0;
        else if(en)
            if(dir)
                Q <= Q+1;
            else
                Q <= Q-1;
        else
            Q <= Q; 
    end

endmodule

module _4bits_updown_mod10_counter(
    input wire clk,
    input wire en,
    input wire reset,
    input wire dir,
    output reg [3:0] Q
);

    always @(posedge clk) begin
        if(reset)
            Q <= 0;
        else if(en)
            if(dir)
                if(Q >= 4'd9)
                    Q <= 0;
                else
                    Q <= Q+1;
            else
                if(Q == 0)
                    Q <= 9;
                else if(Q >= 4'd10)
                    Q <= 9;
                else
                    Q <= Q-1;
        else
            Q <= Q; 
    end

endmodule