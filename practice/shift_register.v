module shift_register(
    input wire clk,
    input wire reset,
    input wire en,
    output reg [3:0] Q
);
    always @(posedge clk)begin
        if(reset)
            Q <= 0;
        else if(en)
            Q <= {1'b0,Q[3:1]};
        else
            Q <= Q;
    end
endmodule

module sin_shift_register(
    input wire clk,
    input wire reset,
    input wire en,
    input wire sin,
    output reg [3:0] Q
);
    always @(posedge clk)begin
        if(reset)
            Q <= 0;
        else if(en)
            Q <= {sin,Q[3:1]};
        else
            Q <= Q;
    end
endmodule


module ring_shift_register(
    input wire clk,
    input wire reset,
    input wire en,
    output reg [3:0] Q
);
    always @(posedge clk)begin
        if(reset)
            Q <= 4'b0001;
        else if(en)
            Q <= {Q[0],Q[3:1]};
        else
            Q <= Q;
    end
endmodule

module johnson_counter (
    input wire clk,
    input wire reset,
    input wire en,
    output reg [3:0] Q
);
    always @(posedge clk) begin
        if(reset)
            Q <= 4'b0000;
        else if(en)
            Q <= {~Q[0],Q[3:1]};
        else
            Q <= Q;
    end
    
endmodule