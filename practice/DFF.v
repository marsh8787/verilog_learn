module dff(
    input wire clk,
    input wire D,
    output reg Q
);

    always @(posedge clk) begin
        Q <= D;
    end

endmodule

module dff2(
    input wire clk,
    input wire D,
    input wire reset,
    output reg Q
);

    always @(posedge clk) begin
        if(reset)
            Q <= 0;
        else
            Q <= D;
    end

endmodule

module dff_async (
    input wire clk,
    input wire reset,
    input wire D,
    output reg Q
);
    always @(posedge clk or posedge reset)begin
        if(reset)
            Q <= 0;
        else
            Q <= D;
    end
    
endmodule