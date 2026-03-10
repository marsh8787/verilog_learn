module alu #(
    parameter WIDTH = 4
) (
    input wire [WIDTH-1:0] A,
    input wire [WIDTH-1:0] B,
    input wire [1:0] op,
    output reg [WIDTH-1:0]Y,
    output reg [3:0] F
);
    reg [WIDTH:0] sum_ext;
    reg sub;
    reg [WIDTH-1:0] Bx;

    reg C,Z,N,V;

    always @(*) begin
        Y = {WIDTH{1'b0}};
        F = 4'b0000;
        sum_ext = {(WIDTH+1){1'b0}};
        sub = 1'b0;
        Bx = {WIDTH{1'b0}};
        C = 0;
        Z = 0;
        N = 0;
        V = 0;

        sub = (op == 2'b01);

        Bx = B ^ {WIDTH{sub}};
        sum_ext = A + Bx + sub;        

        case(op)
            2'b00 : Y = sum_ext[WIDTH-1:0];
            2'b01 : Y = sum_ext[WIDTH-1:0];
            2'b10 : Y = A & B;
            2'b11 : Y = A | B;
            default : Y = {WIDTH{1'b0}};
        endcase


        if(op == 2'b00 || op == 2'b01)begin
            C = sum_ext[WIDTH];
        end
        else begin
            C = 0;
        end

        Z = ~(|Y);

        N = Y[WIDTH-1];

        if(op == 2'b00)begin
            V = (A[WIDTH-1] == B[WIDTH-1]) && (Y[WIDTH-1] != A[WIDTH-1]);
        end
        else if(op == 2'b01)begin
            V = (A[WIDTH-1] != B[WIDTH-1]) && (Y[WIDTH-1] != A[WIDTH-1]);
        end
        else begin
            V = 0;
        end
        
        F = {C,Z,N,V};
    end
endmodule