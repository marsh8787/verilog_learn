module bin2bcd(
    input wire [7:0] bin,
    output wire [11:0] bcd
);

    integer i,j;

    reg [19:0] temp;

    always @(bin) begin
        for(i = 0;i < 20;i = i + 1) temp[i] = 0;
        temp[7:0] = bin;
        for(i = 0; i < 8;i = i + 1) begin
            if(temp[19:16] > 4) temp[19:16] = temp[19:16] + 3'b011;
            if(temp[15:12] > 4) temp[15:12] = temp[15:12] + 3'b011;
            if(temp[11:8] > 4) temp[11:8] = temp[11:8] + 3'b011;
            temp = temp << 1;
        end
    end

    assign bcd = temp[19:8];
    
endmodule