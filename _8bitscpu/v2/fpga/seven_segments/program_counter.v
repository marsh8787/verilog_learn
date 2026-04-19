module program_counter(
    input wire clk,
    input wire reset,
    output reg [7:0] count
);

    integer i;    

    always @(posedge clk)begin
        if(!reset)begin
            count <= 0;
            i <= 0;
        end
        else begin
            if(i < 50000000) begin
                i <= i + 1;
            end
            else begin
                i <= 0;
                if(count < 256)begin
                    count = count +1;
                end
                else begin
                    count <= 0;
                end
            end
        end
    end
endmodule
